//
//  KKindModel.h
//  catTravel
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@class Elements,Data,Location;
@interface KKindModel : JSONModel

//@property (nonatomic, strong) NSArray *search_data;

//@property (nonatomic, assign) CGFloat last_modified;

@property (nonatomic, strong) NSArray *elements;

@end


@interface Elements : NSObject

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign)BOOL more;

@property (nonatomic,strong)NSNumber *index;



@end

@interface Data : NSObject

@property (nonatomic, strong) Location *location;

@property (nonatomic, copy) NSString *name_en;

@property (nonatomic, copy) NSString *slug_url;

@property (nonatomic, assign) BOOL has_route_maps;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *cover_route_map_cover;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *name_orig;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger wish_to_go_count;

@property (nonatomic, assign) NSInteger rating_users;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL has_experience;

@property (nonatomic, copy) NSString *cover_s;

@property (nonatomic, assign) NSInteger visited_count;

@property (nonatomic, assign) NSInteger rating;

@property (nonatomic, copy) NSString *name_zh;

@end

@interface Location : NSObject

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, assign) CGFloat lng;

@end

