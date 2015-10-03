//
//  KindViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "KindViewController.h"

#import "MyHelper.h"
#import "kindCell.h"
#import "KKindModel.h"
#import "JSONModel.h"
#import "KindCollectionReusableView.h"
#import "SubKindViewController.h"
#import "ContainerViewController.h"

#import "FifthViewController.h"
#import "SixViewController.h"
#import "FourthViewController.h"
#import "ThirdViewController.h"
#import "SecondViewController.h"
#import "FirstViewController.h"

#import "BackgroundViewController.h"
#define sKindCell @"kindCell"


@interface KindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView;
    KKindModel*_data;
    
    
    NSMutableArray *_dataArry;
    NSMutableArray *_titleArry;
}

@end

@implementation KindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    self.title=@"分类";
     _dataArry=[[NSMutableArray alloc]init];
    [self initData];
    [self createCollectionView];
    
}

-(void)initData{
    
   
    _titleArry=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:kindURL parameters:nil success:^(AFHTTPRequestOperation * opretion, id respondObject) {
        _data=[[KKindModel alloc]initWithData:respondObject error:nil];
        
        [self createHeaders];
        [_collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *opretion, NSError * error) {
        
        
    }];
    
}
-(void)createHeaders{
    
    
    for (int i=1; i<_data.elements.count; i++) {
        //注册头头视图
   [_collectionView registerClass:[KindCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"KindCollectionReusableView%d",i]];
        
    }
}

-(void)createCollectionView{
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
    return _data.elements.count-1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[[_data.elements objectAtIndex:section+1] objectForKey:@"data"] count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    kindCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:sKindCell forIndexPath:indexPath];

    cell.name.text=[[[_data.elements objectAtIndex:indexPath.section+1] objectForKey:@"data"][indexPath.row]objectForKey:@"name"];
    
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[[_data.elements objectAtIndex:indexPath.section+1] objectForKey:@"data"][indexPath.row]objectForKey:@"cover_route_map_cover"]]];
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth-10*3)/2,(ScreenWidth-10*3)/2);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
        
        if (kind==UICollectionElementKindSectionHeader) {
            KindCollectionReusableView    *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"KindCollectionReusableView%d",indexPath.section+1] forIndexPath:indexPath];
           
            NSString *str=[[_data.elements objectAtIndex:indexPath.section+1]objectForKey:@"title"];
           
            
            [view createLabel:str  more:[[_data.elements objectAtIndex:indexPath.section+1]objectForKey:@"more"]  block:^{
                
                SubKindViewController *sub=[[SubKindViewController alloc]init];
                [self.navigationController pushViewController:sub animated:YES];
                
                sub.index=[[_data.elements objectAtIndex:indexPath.section+1]objectForKey:@"index"];
                

            }];
            

            return view ;
        }
    
         return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.width, 50);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger type=[[[[[_data.elements objectAtIndex:indexPath.section+1]objectForKey:@"data"]objectAtIndex:indexPath.row]objectForKey:@"type"]integerValue];
    NSString *idNumber=[[[[_data.elements objectAtIndex:indexPath.section+1]objectForKey:@"data"]objectAtIndex:indexPath.row]objectForKey:@"id"];
    
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
    
    //设置动画
    CATransition *anima=[CATransition animation];
    [anima setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //设置动画时间
    anima.duration = 1;
    anima.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:anima forKey:nil];
    container.viewControllers          = @[firstController, secondController, thirdController, fourthController, fifthController, sixController];
        container.hidesBottomBarWhenPushed=YES;
    
    
    
    [self.navigationController pushViewController:container animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
