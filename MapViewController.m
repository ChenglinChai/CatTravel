//
//  MapViewController.m
//  catTravel
//
//  Created by qianfeng on 16/9/24.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface MapViewController ()<MAMapViewDelegate>{
    
    MAMapView *_mapView;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)viewWillDisappear:(BOOL)animated
{//地图不用的时候结束使用
    [super viewWillDisappear:animated];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeFromSuperview];
   _mapView.delegate=nil;
   _mapView=nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //高德地图
    
    _mapView=[[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate=self;
    [self.view addSubview:_mapView];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 25, 25)];
    [button setBackgroundImage:[UIImage imageNamed: @"detail_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:button];
    
    //大头针
    MAPointAnnotation *pointAninotation=[[MAPointAnnotation alloc]init];
    _mapView.mapType=MAMapTypeStandard;//普通地图
    _mapView.region=MACoordinateRegionMake(CLLocationCoordinate2DMake(self.latitude, self.longitude),MACoordinateSpanMake(0.1, 0.1));//精度 精确到10米
    pointAninotation.coordinate=CLLocationCoordinate2DMake(self.latitude, self.longitude);
    pointAninotation.title=self.address;
    _mapView.delegate=self;
    [_mapView addAnnotation:pointAninotation];
}
-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - map协议
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    static NSString *pointReuseIndetifier=@"pointReuseIndetifier";
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
    MAPinAnnotationView *annotationView=(MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
    if (annotationView==nil) {
        annotationView=[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
    }
    annotationView.canShowCallout=YES;//设置气泡可以弹出，默认为NO
    annotationView.animatesDrop=YES;//设置标注动画显示默认为NO；
    annotationView.draggable=YES;//设置标注可以拖动，默认为NO
    annotationView.pinColor=MAPinAnnotationColorRed;//大头针的颜色
    return annotationView;
    }
    return nil;
    
}

-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    //改变区域的时候 前面的地图清空
    [_mapView removeFromSuperview];
    [self.view addSubview:_mapView];
    
}



@end
