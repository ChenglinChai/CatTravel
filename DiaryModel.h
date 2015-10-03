//
//  DiaryModel.h
//  catTravel
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryModel : NSObject

@property (nonatomic, copy)NSString *userName;
//图像
@property (nonatomic, copy)NSString *photo;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *date;

@property (nonatomic,copy)NSString *day;

@property (nonatomic, copy)NSString *text;

@property (nonatomic, copy)NSString *photo_weblive;

@property (nonatomic, copy)NSString *local_time;


@end
