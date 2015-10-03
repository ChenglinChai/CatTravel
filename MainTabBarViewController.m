//
//  MainTabBarViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HotViewController.h"
#import "KindViewController.h"
#import "SearchViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    HotViewController *hot=[[HotViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:hot];
    
    
    KindViewController *kind=[[KindViewController alloc]init];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:kind];
    
    
    SearchViewController *search=[[SearchViewController alloc]init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:search];
    
    
    self.viewControllers=@[nav1,nav2,nav3];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
