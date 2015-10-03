//
//  SubKindViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubKindViewController.h"
#import "kindCell.h"
#import "MoreKind.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixViewController.h"
#import "BackgroundViewController.h"

#define sKindCell @"kindCell"
//#define moreURL @"http://api.breadtrip.com/destination/index_places/"
@interface SubKindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView;
    MoreKind *_moreModel;
    NSDictionary *_dataDic;
    NSMutableArray *_dataArry;
}

@end

@implementation SubKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataDic=[[NSDictionary alloc]init];
  

}
-(void)initData{
    
    NSInteger a=[self.index integerValue];
    NSString *url=[NSString stringWithFormat:moreURL,a];
   
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * opretion, id respondObject) {
        
        _dataDic =[NSJSONSerialization JSONObjectWithData:respondObject options:NSJSONReadingMutableContainers error:nil];
        [self modelFactory];
       
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *opretion, NSError * error) {
        
        
    }];

  }
-(void)modelFactory{
    _dataArry=[[NSMutableArray alloc]init];
    
    NSArray *arry=[_dataDic objectForKey:@"data"];
   
    for (NSDictionary *dic in arry) {
        MoreKind *more=[[MoreKind alloc]init];
        more.name=[dic objectForKey:@"name"];
        more.cover_route_map_cover=[dic objectForKey:@"cover_route_map_cover"];
        more.type=[dic objectForKey:@"type"];
        more.idNumber=[dic objectForKey:@"id"];
        
        [_dataArry addObject:more];
        
    }
    
}

-(void)createView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight ) collectionViewLayout:flowLayout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    
    //注册_collletionView xib
    [_collectionView registerNib:[UINib nibWithNibName:@"kindCell" bundle:nil] forCellWithReuseIdentifier:@"kindCell"];
    
}

#pragma mark - collectioncell  协议
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArry.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    kindCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:sKindCell forIndexPath:indexPath];
   
    MoreKind *model=_dataArry[indexPath.row];
    cell.name.text=model.name;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.cover_route_map_cover]];
   
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth-10*3)/2,(ScreenWidth-10*3)/2); 
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
    MoreKind *model=_dataArry[indexPath.row];
    NSInteger type=[model.type integerValue] ;
    NSString *idNumber=model.idNumber;
  
    BackgroundViewController *back=[[BackgroundViewController alloc]init];
    back.type=type;
    back.idNumber=idNumber;
    
    FirstViewController *firstController   = [[FirstViewController alloc] init];
    firstController.title                  = @"全部";
    firstController.type=type;
    firstController.idNumber=idNumber;
    
    
    SecondViewController *secondController = [[SecondViewController alloc] init];
    secondController.title                 = @"景点";
    secondController.type=type;
    secondController.idNumber=idNumber;
    
    
    ThirdViewController *thirdController   = [[ThirdViewController alloc] init];
    thirdController.title                  = @"住宿";
    thirdController.type=type;
    thirdController.idNumber=idNumber;
    
    
    FourthViewController *fourthController = [[FourthViewController alloc] init];
    fourthController.title                 = @"餐厅";
    fourthController.type=type;
    fourthController.idNumber=idNumber;
    
    
    FifthViewController *fifthController   = [[FifthViewController alloc] init];
    fifthController.title                  = @"休闲娱乐";
    fifthController.type=type;
    fifthController.idNumber=idNumber;
    
    SixViewController *sixController       = [[SixViewController alloc] init];
    sixController.title                    = @"购物";
    sixController.type=type;
    sixController.idNumber=idNumber;
 
    ContainerViewController *container=[[ContainerViewController alloc]init];
    
    container.viewControllers          = @[firstController, secondController, thirdController, fourthController, fifthController, sixController];
    container.hidesBottomBarWhenPushed=YES;
    //设置动画
    CATransition *anima=[CATransition animation];
    [anima setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //设置动画时间
    anima.duration = 1;
    anima.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:anima forKey:nil];
    [self.navigationController pushViewController:container animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
