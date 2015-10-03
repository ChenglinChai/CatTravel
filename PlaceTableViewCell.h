//
//  PlaceTableViewCell.h
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface PlaceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *discription;
@property (weak, nonatomic) IBOutlet UILabel *gone;
@property (weak, nonatomic) IBOutlet StarView *startView;

@end
