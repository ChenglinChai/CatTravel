//
//  PlaceModel.h
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *rating;
//点评
@property (nonatomic,copy)NSString *tips_count;

//去过
@property (nonatomic,copy)NSString *visited_count;

//描述
@property (nonatomic,copy)NSString *recommended_reason;

@property (nonatomic,copy)NSString *cover_s;


//详情top视图
@property (nonatomic,copy)NSString *topView;
//概况
@property (nonatomic,copy)NSString *des;
//地址
@property (nonatomic,copy)NSString *address;
//到达方式
@property (nonatomic,retain)NSString *arrive;
//开放时间
@property (nonatomic,retain)NSString *openTime;
//联系方式
@property (nonatomic,retain)NSString *tel;

//坐标
@property (nonatomic, copy)NSString *lat;
@property (nonatomic, copy)NSString *lng;


@property (nonatomic)NSInteger type;
@property (nonatomic,copy)NSString *idNumber;


@end
