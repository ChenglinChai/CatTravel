//
//  StoryModel.h
//  catTravel
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryModel : NSObject

@property (nonatomic, copy)NSString *index_title;
@property (nonatomic, copy)NSString *cover_image_1600;

//user
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *avatar_m;

@property (nonatomic, strong)NSNumber *spot_id;
@end
