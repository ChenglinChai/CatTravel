//
//  AppDelegate.h
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "MainTabBarViewController.h"
#import "PlaceModel.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) MainTabBarViewController *mainTabVC;


@end

