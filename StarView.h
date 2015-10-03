//
//  StarView.h
//  LoveLimitFreeDemo
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView{
    
    //背景的白色星星
    UIImageView *_backView;
    //前面的橙色星星
    UIImageView *_frontView;
}

-(void)setStarValue:(CGFloat)value;

@end
