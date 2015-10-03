//
//  SearchModel.h
//  catTravel
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property (nonatomic, copy)NSString *name;
//图
@property (nonatomic,copy)NSString *cover_image;
//距离
@property (nonatomic,copy)NSString *waypoints;
//收藏
 @property (nonatomic, copy)NSString *recommendations;
//天
@property (nonatomic,copy)NSString *day_count;
//日期
@property (nonatomic, copy)NSString *date_added;

@property (nonatomic,copy)NSString *idNumber;
@end
