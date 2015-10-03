//
//  KindCollectionReusableView.m
//  catTravel
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "KindCollectionReusableView.h"

@implementation KindCollectionReusableView

-(void)createLabel:(NSString *)str more:(NSNumber *)more  block:(BlOCK)b {
    if (!self.label) {
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(10,10, 200, self.height)];
        self.block=b;
        self.userInteractionEnabled=YES;
         self.label.text=str;
        
        [self addSubview:self.label];
       
    }
    if ([more isEqualToNumber:@(1)]) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.width-30, 20, 20, 20)];
        imageView.image=[UIImage imageNamed: @"more.png"];
        [self addSubview:imageView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toNextView:)];
        [self addGestureRecognizer:tap];
        
    }
   
    
}
-(void)toNextView:(id)tap{
    if (self.block) {

    self.block();
        
    }
   
   
}

@end
