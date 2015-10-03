//
//  Define.h
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef catTravel_Define_h
#define catTravel_Define_h

#import "Factory.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NetInterface.h"
#import "UIView+Addition.h"
#import "JSONModel.h"
#import "MyHelper.h"
//调试 代码的宏
/*
 如果定义过宏DEBUG 那么 宏DDLog 表示NSLog函数 否则 表示空
 
 DDLog(...) ...表示 变参宏
 NSLog(__VA_ARGS__)  __VA_ARGS__ 表示接收宏中写的变参
 
 DEBUG  宏  在 调试模式(Debug)下会定义
 在发布模式(Release)不会定义
 */
#ifdef DEBUG
#define DDLog(...) NSLog(__VA_ARGS__)
#else
#define DDLog(...)
#endif

#endif
