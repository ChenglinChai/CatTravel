//
//  BackgroundViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BackgroundViewController.h"
#import "PlaceTableViewCell.h"
#import "PlaceModel.h"
#import "StarView.h"
#import "JHRefresh.h"
#import "CellDetailViewController.h"
#import "ContainerViewController.h"
#import "AppDelegate.h"
@interface BackgroundViewController ()<UITableViewDelegate,UITableViewDataSource>{
    AppDelegate *app;
}
//是加载更多
@property (nonatomic, assign)BOOL isLoadingMore;
//是刷新
@property (nonatomic, assign)BOOL  isRefresh;
@end

@implementation BackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNetData];
    [self createTableView];
    self.view.backgroundColor=RGB(255, 244, 213);
}

-(void)getNetData{
    
    
}
-(void)resetParame{
   
}

-(void)createTableView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.width-20, self.view.height-100) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    //添加刷新控件
    [self createRefreshView];
    
}
-(void)createRefreshView{
    //将self改为弱引用，避免强引用导致内存泄露
    /*
     __weak typeof(self) weakSelf = self;避免block与self产生强引用环，如果不用__weak的话，self对block是强引用，block内又对self产生了强引用，这样的话self的引用计数和block的引用计数永远都不可能为0
     */
    __weak typeof(self) weakSelf=self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefresh=YES;
        //刷新获取当前的分类和最新数据
        [weakSelf resetParame];
        //调用请求
        [weakSelf getNetData];
        
        
    }];
    
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isLoadingMore=YES;
        //增加页码
        weakSelf.startNumber+=20;
        //获取网络请求
        [weakSelf getNetData];
    }];
    
    
}
-(void)refreshTableView{
    if (_isRefresh) {
        _isRefresh=NO;
        [_tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }
    if (_isLoadingMore) {
        _isLoadingMore=NO;
        
        [_tableView footerEndRefreshing];
    }{
        
    }
    
    [_tableView reloadData];
}

-(void)createWithMode:(PlaceModel *)model dic:(NSDictionary *)dic{
    
    
    model.name=[dic objectForKey:@"name"];
    model.rating=[dic objectForKey:@"rating"];
    model.cover_s=[dic objectForKey:@"cover_s"];
    model.tips_count=[dic objectForKey:@"tips_count"];
    model.recommended_reason=[dic objectForKey:@"recommended_reason"];
    if ([model.recommended_reason isKindOfClass:[NSNull class]]) {
        model.recommended_reason = @"";
    }
    model.visited_count=[dic objectForKey:@"visited_count"];
    
    
    model.topView=[dic objectForKey:@"cover_route_map_cover"];
    model.des=[dic objectForKey:@"description"];
    model.address=[dic objectForKey:@"address"];
    model.arrive=[dic objectForKey:@"arrival_type"];
    model.openTime=[dic objectForKey:@"opening_time"];
    model.tel=[dic objectForKey:@"tel"];
    
    model.lat=[[dic objectForKey:@"location"]objectForKey:@"lat"];
    model.lng=[[dic objectForKey:@"location"]objectForKey:@"lng"];
    
    model.type=self.type;
    model.idNumber=self.idNumber;
    
}

#pragma mark - UITableViewDelegate,UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"Identifier";
    PlaceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PlaceTableViewCell" owner:self options:nil]lastObject];
    }
    PlaceModel *model=_dataArry[indexPath.row];
    cell.title.text=model.name;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.cover_s]];
    cell.discription.text=model.recommended_reason;
    cell.comment.text=[NSString stringWithFormat:@"%@点评",model.tips_count];
    cell.gone.text=[NSString stringWithFormat:@"%@  人去过",model.visited_count];
    [cell.startView setStarValue:[model.rating floatValue]];
    cell.layer.cornerRadius=10;
    cell.layer.masksToBounds=YES;
    cell.layer.borderWidth=5;
    cell.layer.borderColor=[RGB(255, 244, 213)CGColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 126;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlaceModel *model=_dataArry[indexPath.row];
    
    CellDetailViewController *cellDetail=[[CellDetailViewController alloc]init];
    cellDetail.model=model;
    
    [self.view.window.rootViewController presentViewController:cellDetail animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
