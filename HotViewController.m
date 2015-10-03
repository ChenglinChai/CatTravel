//
//  HotViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotViewController.h"
#import "StoryModel.h"
#import "StoryCell.h"
#import "JHRefresh.h"
#import "StoryDetialViewController.h"

@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    
    UITableView *_tableView;
    UIScrollView *_scrollwView;
    NSMutableArray *_dataArry;

    UIPageControl *_pageControl;
    NSArray *_topIdNumber;
    
}
@property (nonatomic,assign)BOOL isRefresh;
@property (nonatomic,assign)BOOL isLoadingMore;
@property (nonatomic)NSInteger startNumber;

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.title=@"推荐";
    [self initData];
    
    [self createTableView];
    [self createPageControl];
    [self createTimer];
    [self createRefreshView];
    
}

-(void)createRefreshView{
    __weak typeof(self) weakSelf=self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefresh=YES;
        [weakSelf resetParam];
        [weakSelf initData];
    }];
    
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isLoadingMore=YES;
        weakSelf.startNumber+=13;
        [weakSelf initData];
        
    }];
    
}

-(void)resetParam{
    self.startNumber=0;
    
}

-(void)initData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
   [manager GET:storyURL parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.startNumber],@"start", nil] success:^(AFHTTPRequestOperation * opretion, id respondObject) {
       
       NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:respondObject options:NSJSONReadingMutableContainers error:nil];
      
       NSArray *arry=[[dictionary objectForKey:@"data"]objectForKey:@"hot_spot_list"];
     
       _topIdNumber=[NSArray arrayWithArray:arry];
       [self createScrollwView:arry];
       if (self.startNumber==0) {
            _dataArry=[[NSMutableArray alloc]init];
           [self createModelFactory:arry];
           
       }else{
           
           [self createModelFactory:arry];
           
       }
       
           
       [self refreshTableView];
      
       
    } failure:^(AFHTTPRequestOperation * opretion, NSError * error) {
        
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
    }
    [_tableView reloadData];
}


-(void)createModelFactory:(NSArray *)arry{
    for (NSDictionary *dic in arry) {
        StoryModel *model=[[StoryModel alloc]init];
        model.index_title=[dic objectForKey:@"index_title"];
        model.cover_image_1600=[dic objectForKey:@"index_cover"];
        model.name=[[dic objectForKey:@"user"]objectForKey:@"name"];
        model.avatar_m=[[dic objectForKey:@"user"]objectForKey:@"avatar_m"];
        model.spot_id=[dic objectForKey:@"spot_id"];
        
        [_dataArry addObject:model];
    }
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
   
    [self.view addSubview:_tableView];
    
    
}


-(void)createScrollwView:(NSArray *)arry{
    
    //解决跳转图片下移问题
//    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 1)];
//    lineView.backgroundColor = [UIColor clearColor];
//    lineView.userInteractionEnabled = NO;
//    [self.view addSubview:lineView];
    _scrollwView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 250)];
    _scrollwView.delegate=self;
    _scrollwView.contentSize=CGSizeMake(self.view.width*4, 0);
    _scrollwView.pagingEnabled=YES;
    _scrollwView.showsHorizontalScrollIndicator=NO;
    _scrollwView.showsVerticalScrollIndicator=NO;

    for (int i=0; i<4; i++) {
        if (i==3) {
            [self scrollwAddImage:arry num1:i num2:0];
        }else {
            
            [self scrollwAddImage:arry num1:i num2:i];
//            
//            _topIdNumber=[[NSMutableArray alloc]init];
//            
//            [_topIdNumber addObject:[arry[i] objectForKey:@"spot_id"]];
//            NSLog(@"%@",_topIdNumber);
//            
////            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNextView:)];
////            [imageView addGestureRecognizer:tap];
////            imageView.userInteractionEnabled=YES;
            
        }
    }
   _tableView.tableHeaderView=_scrollwView;
    [_tableView addSubview:_pageControl];
    
}


-(void)scrollwAddImage:(NSArray *)arry num1:(int)num1 num2:(int)num2{
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(num1*self.view.width, 0, self.view.width, 250)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[arry[num2]objectForKey:@"index_cover"]]];
    
    imageView.tag=100+num1;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNextView:)];
                [imageView addGestureRecognizer:tap];
                imageView.userInteractionEnabled=YES;
    
    [_scrollwView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20+num1*self.view.width, 10, self.view.width, 30)];
    label.text=@"#旅途故事🚗#";
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont boldSystemFontOfSize:17];
    [_scrollwView addSubview:label];
    
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0+num1*self.view.width, 210, self.view.width-0, 30)];
    label1.text=[arry[num2] objectForKey:@"text"];
    label1.textColor=[UIColor whiteColor];
    label1.font=[UIFont boldSystemFontOfSize:13];
    label1.backgroundColor=RGBA(56, 56, 56, 0.3);
    [_scrollwView addSubview:label1];
}
-(void)createTimer{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(movePicture) userInfo:nil repeats:YES];
    
}
-(void)movePicture{
    int pagenumber=floor(_scrollwView.contentOffset.x-self.view.width)/self.view.width+1;
    [_scrollwView setContentOffset:CGPointMake(self.view.width*(pagenumber+1), 0) animated:YES];
    
}
-(void)createPageControl{
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(50, 190, self.view.width-100, 30)];
    _pageControl.numberOfPages=3;
    
    _pageControl.currentPage=0;
    
    
    
}
-(void)tapToNextView:(UITapGestureRecognizer *)tap {
    NSLog(@"%d",tap.view.tag);
    StoryDetialViewController *top=[[StoryDetialViewController alloc]init];
    top.idNumber=[_topIdNumber[tap.view.tag-100] objectForKey:@"spot_id"] ;
    [self.navigationController pushViewController:top animated:YES];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count-3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"StoryCell";
    StoryCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"StoryCell" owner:self options:nil]lastObject];
        
    }
    StoryModel *model=_dataArry[indexPath.row+3];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.cover_image_1600]];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:model.avatar_m]];
    cell.userImage.layer.cornerRadius=35/2;
    cell.userImage.layer.masksToBounds=YES;
    cell.name.text=model.name;
    cell.layer.borderWidth=5;
    cell.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    cell.layer.cornerRadius=15;
    cell.layer.masksToBounds=YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 184;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int pageNumber=floor(scrollView.contentOffset.x-self.view.width)/self.view.width+1;
    if (pageNumber==3) {
        _pageControl.currentPage=0;
        [_scrollwView setContentOffset:CGPointZero animated:NO];
    }else{
        
        _pageControl.currentPage=pageNumber;
        
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StoryModel *model=_dataArry[indexPath.row+3];
    StoryDetialViewController *sto=[[StoryDetialViewController alloc]init];
    sto.idNumber=[model.spot_id stringValue];
    [self.navigationController pushViewController:sto animated:YES];
}


@end
