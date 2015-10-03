//
//  KindCollectionReusableView.h
//  catTravel
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlOCK)(void);



@interface KindCollectionReusableView : UICollectionReusableView
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,copy)BlOCK block;

-(void)createLabel:(NSString *)str more:(NSString *)more block:(BlOCK)b;
@end
