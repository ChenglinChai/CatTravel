//
//  SubSearchViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubSearchViewController.h"
#import "SearchModel.h"
#import "SearchTableViewCell.h"
#import "JHRefresh.h"
#import "DiarySearchViewController.h"
@interface SubSearchViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataArry;
    
   
}
//是加载更多
@property (nonatomic, assign)BOOL isLoadingMore;
//是刷新
@property (nonatomic, assign)BOOL  isRefresh;
@property (nonatomic) NSInteger startNumber;
@end

@implementation SubSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    [self resetParame];
    [self initData];
    [self createTableView];
    [self createRefreshView];
   
    
    
}
-(void)createRefreshView{
    __weak typeof(self) weakSelf=self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefresh=YES;
        //刷新获取当前的分类和最新数据
        [weakSelf resetParame];
        //调用请求
        [weakSelf initData];
        
        
    }];
    
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isLoadingMore=YES;
        //增加页码
        weakSelf.startNumber+=20;
        //获取网络请求
        [weakSelf initData];
    }];
    
    
}
-(void)resetParame{
    _startNumber=0;
    
}
-(void)initData{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
 
   [manager GET:searchURL parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.text, @"key",[NSString stringWithFormat:@"%d",self.startNumber],@"start",nil] success:^(AFHTTPRequestOperation * opretion, id respondObject) {
       
       NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:respondObject options:NSJSONReadingMutableContainers error:nil];
      // NSLog(@"%@",opretion.request.URL);
       if (_startNumber==0) {
           
       _dataArry =[[NSMutableArray alloc]init];
      [self createModelFactory:dictionary];
       
       
       }else{
            [self createModelFactory:dictionary];
           
       }
       [self refreshView];
    } failure:^(AFHTTPRequestOperation *opretion , NSError * error) {
        [self refreshView];
        
    }];
    
}
//刷新页面
-(void)refreshView{
    if (_isRefresh) {
        _isRefresh=NO;
        [_tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }
    if (_isLoadingMore) {
        _isLoadingMore=NO;
        
        [_tableView footerEndRefreshing];
    }
    
    [_tableView reloadData];
    
}

-(void)createModelFactory:(NSDictionary *)dictionary{
    
    
    NSArray *arry=[dictionary objectForKey:@"trips"];
    
    for (NSDictionary *dic in arry) {
        SearchModel *model=[[SearchModel alloc]init];
        model.name=[dic objectForKey:@"name"];
        model.cover_image=[dic objectForKey:@"cover_image"];
        model.waypoints=[[dic objectForKey:@"waypoints"]stringValue];
        model.recommendations=[[dic objectForKey:@"recommendations"]stringValue];
        model.day_count=[[dic objectForKey:@"day_count"]stringValue];
        model.idNumber=[[dic objectForKey:@"id"]stringValue];
        
        NSNumber *totalSeconds=[dic objectForKey:@"date_added"];
        
        //时间转换
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[totalSeconds integerValue]];
        NSTimeZone *zone=[NSTimeZone systemTimeZone];
        NSInteger interval=[zone secondsFromGMTForDate:date];
        NSDate *localeDate=[date dateByAddingTimeInterval:interval];
        NSDateFormatter *df=[[NSDateFormatter alloc]init];
        df.dateFormat=@"YYYY-MM-dd";
        NSString *str=[df stringFromDate:localeDate];
        model.date_added=str;

        [_dataArry addObject:model];
        
    }

}

-(void)createTableView{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.width-20, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
   [self.view addSubview:_tableView];
    
}

#define mark - UITableViewDelegate)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"SearchCell";
    SearchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SearchTableViewCell" owner:self options:nil]lastObject];
        
    }
    SearchModel *model=_dataArry[indexPath.row];
    cell.name.text=model.name;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.cover_image]];
    cell.date.text=model.date_added;
    cell.label1.text=model.waypoints;
    cell.label2.text=model.recommendations;
    cell.label3.text=[NSString stringWithFormat:@"%@天",model.day_count];
    
    cell.layer.borderWidth=5;
    cell.layer.masksToBounds=YES;
    cell.layer.cornerRadius=12;
    cell.layer.borderColor=[[UIColor orangeColor]CGColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchModel *model=_dataArry[indexPath.row];
    DiarySearchViewController *diary=[[DiarySearchViewController alloc]init];
    diary.idNumber=model.idNumber;
    diary.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:diary animated:YES];
    
    
}





@end
