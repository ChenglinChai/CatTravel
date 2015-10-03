//
//  StoryDetialViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "StoryDetialViewController.h"
#import "DetailStoryCell.h"
#import "DetailStoryModel.h"

@interface StoryDetialViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    NSMutableArray *_dataArry;
    
}

@end

@implementation StoryDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createTableView];
    [self createTableView];
    self.view.backgroundColor=[UIColor whiteColor];
       
}

-(void)initData{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
   [manager GET:subStoUrl parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.idNumber,@"spot_id", nil] success:^(AFHTTPRequestOperation * operation, id respondObject) {
       NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:respondObject options:NSJSONReadingMutableContainers error:nil];
       
       [self createTopView:dictionary];
       _dataArry=[[NSMutableArray alloc]init];
       NSArray *arry=[[[dictionary objectForKey:@"data"]objectForKey:@"spot"]objectForKey:@"detail_list"];
       for (NSDictionary *dic in arry) {
           
           DetailStoryModel *model=[[DetailStoryModel alloc]init];
           model.photo=[dic objectForKey:@"photo"];
           model.text=[dic objectForKey:@"text"];
           
           [_dataArry addObject:model];
    }
       [_tableView reloadData];
       
    } failure:^ (AFHTTPRequestOperation * operation, NSError * error) {
        
        
    }];
    
    
}
-(void)createTableView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10, 74, self.view.width-20, self.view.height-64-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _tableView.estimatedRowHeight=44;
}
-(void)createTopView:(NSDictionary *)dictionary{
    
   
    
    
    NSString *str=[[[dictionary objectForKey:@"data"]objectForKey:@"spot"]objectForKey:@"text"];
    CGRect textRect=[str boundingRectWithSize:CGSizeMake(self.view.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, textRect.size.height+270)];
   // view.backgroundColor=[UIColor yellowColor];
  
    
    NSString *imageUrl=[[[[dictionary objectForKey:@"data"]objectForKey:@"trip"]objectForKey:@"user"]objectForKey:@"avatar_l"];
    UIImageView *imaeView=[[UIImageView alloc]initWithFrame:CGRectMake(150, 30, self.view.width-300,self.view.width-300)];
    imaeView.layer.masksToBounds=YES;
    imaeView.layer.cornerRadius=(self.view.width-300)/2;
    
    [imaeView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [view addSubview:imaeView];
    
    UILabel *userName=[[UILabel alloc]initWithFrame:CGRectMake(100, imaeView.bottom+5, self.view.width-200, 30)];
    userName.text=[NSString stringWithFormat:@"by %@",[[[[dictionary objectForKey:@"data"]objectForKey:@"trip"]objectForKey:@"user"]objectForKey:@"name"]];
    userName.textAlignment=NSTextAlignmentCenter;
    userName.textColor=[UIColor grayColor];
    [view addSubview:userName];
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, userName.bottom+10, self.view.width-20, 0)];
    textLabel.text=str;
    textLabel.numberOfLines=0;
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.textColor=RGB(52, 52, 52);
    [textLabel sizeToFit];
    [view addSubview:textLabel];
    
    _tableView.tableHeaderView=view;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"DetailStoryCell";
    DetailStoryCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DetailStoryCell" owner:self options:nil]lastObject];
    }
    DetailStoryModel *model=_dataArry[indexPath.row];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    cell.label.text=model.text;

   
    return cell;
    
}





@end
