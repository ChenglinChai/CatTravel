//
//  StarView.m
//  LoveLimitFreeDemo
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "StarView.h"

@implementation StarView

/*
 xib 上使用自定义视图，就需要解归档
 -(id)initWithCoder:(NSCoder *)aDecoder
 上面的这个方法就是解归档使用的
 相当于执行了 xib中会默认执行一些属性
 -(id)initWithFrame:(CGRect)frame:(CGRect)frame{
   self=[super initWithFrame:frame];
   if(self){
   self.backgroundColor=[UIColor orangeColor];
  self.XXX=XXX;
 }
   return self;
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    
    _backView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 65, 23)];
    _backView.image=[UIImage imageNamed:@"StarsBackground.png"];
    [self addSubview:_backView];
    
    _frontView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 65, 23)];
    //
    _frontView.contentMode=UIViewContentModeLeft;
    //允许裁剪
    _frontView.clipsToBounds=YES;
    _frontView.image=[UIImage imageNamed:@"StarsForeground.png"];
    [self addSubview:_frontView];

}

-(void)setStarValue:(CGFloat)value{
 
    _frontView.width=63*value/5;
    
}

@end
