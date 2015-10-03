//
//  DiarySearchViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DiarySearchViewController.h"
#import "DiaryModel.h"
#import "DiaryCell.h"


@interface DiarySearchViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    NSDictionary *_dataDic;
    NSArray *_daysArry;
    NSString *_titlename;
    UILabel *_topLabel;
}

@end

@implementation DiarySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initData];
    
    [self createTableView];

}

-(void)initData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:diaryURL,self.idNumber];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * opretion, id respondObject) {
        
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:respondObject options:NSJSONReadingMutableContainers error:nil];
        
        [self createTopView:dictionary];
    
         _daysArry=[dictionary objectForKey:@"days"];
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation * opretion, NSError * error) {
        
    }];
    
}

-(void)createTopView:(NSDictionary *)dic{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(120, -170, _tableView.width-240, _tableView.width-240)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[dic objectForKey:@"user"]objectForKey:@"avatar_l"]]];
    imageView.layer.cornerRadius=imageView.width/2;
    imageView.layer.masksToBounds=YES;
    [_tableView addSubview:imageView];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(50, imageView.bottom+10, _tableView.width-100, 30)];
    title.text=[dic objectForKey:@"name"];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=RGB(59, 59, 59);
    [_tableView addSubview:title];
    
    UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, title.bottom+5, _tableView.width-100, 20)];
    userLabel.text=[NSString stringWithFormat:@"by  %@",[[dic objectForKey:@"user"]objectForKey:@"name"]];
    userLabel.textAlignment=NSTextAlignmentCenter;
    userLabel.font=[UIFont systemFontOfSize:12];
    userLabel.textColor=RGB(117, 117, 117);
    
    [_tableView addSubview:userLabel];
    
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(15, 0, self.view.width-30, self.view.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _daysArry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[[_daysArry objectAtIndex:section]objectForKey:@"waypoints"]count];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *identifier=@"DiaryCell";
    DiaryCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DiaryCell" owner:self options:nil]lastObject];
    }
   
    cell.desc.text=[[[[_daysArry objectAtIndex:indexPath.section]objectForKey:@"waypoints"]objectAtIndex:indexPath.row]objectForKey:@"text"];
    [cell sizeToFit];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[[[_daysArry objectAtIndex:indexPath.section]objectForKey:@"waypoints"]objectAtIndex:indexPath.row]objectForKey:@"photo_weblive"]]];
    cell.time.text=[[[[_daysArry objectAtIndex:indexPath.section]objectForKey:@"waypoints"]objectAtIndex:indexPath.row]objectForKey:@"local_time"];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str=[[[[_daysArry objectAtIndex:indexPath.section]objectForKey:@"waypoints"]objectAtIndex:indexPath.row]objectForKey:@"text"];
    
    CGRect textRect=[str boundingRectWithSize:CGSizeMake(_tableView.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    return textRect.size.height+450;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[_daysArry objectAtIndex:section]objectForKey:@"date"];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
        
    
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=RGBA(175, 175, 175, 0.5);
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    NSString *day=[NSString stringWithFormat:@"第 %@ 天",[[[_daysArry objectAtIndex:section]objectForKey:@"day"]stringValue]];
    NSString *date=[[_daysArry objectAtIndex:section]objectForKey:@"date"];

    label.text=[NSString stringWithFormat:@"%@ 始于%@",day,date];
    label.textColor=RGB(67, 158, 159);
    [view addSubview:label];
        return view;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     _tableView.contentInset=UIEdgeInsetsMake(80, 0, 0, 0);
}
@end
