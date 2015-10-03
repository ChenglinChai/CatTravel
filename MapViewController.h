//
//  MapViewController.h
//  catTravel
//
//  Created by qianfeng on 16/9/24.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController

@property (nonatomic)double latitude;
@property (nonatomic)double longitude;
@property (nonatomic,copy) NSString *address;
@end
