//
//  FirstViewController.h
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BackgroundViewController.h"
#import "ViewWillShow.h"
@interface FirstViewController : BackgroundViewController<ViewWillShow>
@property (nonatomic)NSInteger type;
@property (nonatomic,copy)NSString *idNumber;
@end
