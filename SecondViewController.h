//
//  SecondViewController.h
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BackgroundViewController.h"
#import "ViewWillShow.h"
@interface SecondViewController : BackgroundViewController<ViewWillShow>
@property (nonatomic)NSInteger type;
@property (nonatomic,copy)NSString *idNumber;
@end
