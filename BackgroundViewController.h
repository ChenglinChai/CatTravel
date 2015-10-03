//
//  BackgroundViewController.h
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "ContainerViewController.h"
#import "PlaceModel.h"
@interface BackgroundViewController : BaseViewController{
    
    NSMutableArray *_dataArry;
    UITableView *_tableView;
}
@property (nonatomic)NSInteger startNumber;

@property (nonatomic)NSInteger type;
@property (nonatomic,copy)NSString *idNumber;

-(void)getNetData;

-(void)refreshTableView;
//重置请求参数
-(void)resetParame;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)createWithMode:(PlaceModel *)model dic:(NSDictionary *)dic;

@end
