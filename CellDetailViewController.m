//
//  CellDetailViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CellDetailViewController.h"
#import "PlaceDetailCell.h"
#import "MapViewController.h"
#import "MapViewController.h"
#import "CantMissViewController.h"


#define kHeaderHeight 200

@interface CellDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    UIImageView *_imageView;
}

@end

@implementation CellDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 25, 25)];
    [button setBackgroundImage:[UIImage imageNamed: @"detail_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
}


-(void)createView{
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    
    _tableView.contentInset=UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    [self createImageView];
    [self createButton];
}
-(void)createButton{
    UIButton *like=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50, ScreenHeight-50, 40, 40)];
    [like setImage:[UIImage imageNamed: @"save.png"] forState:UIControlStateNormal];
    like.backgroundColor=[UIColor clearColor];
    [self.view addSubview:like];
    [like addTarget:self  action:@selector(clickToSave:) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)clickToSave:(UIButton *)btn{
    
    [btn setImage:[UIImage imageNamed: @"save-press.png"] forState:UIControlStateNormal];
    
}
-(void)createImageView{
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -kHeaderHeight, ScreenWidth, kHeaderHeight)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.topView]];
    [_tableView addSubview:_imageView];
    
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffSet = scrollView.contentOffset.y;
    CGFloat xOffSet = (yOffSet + kHeaderHeight)/2;
    if (yOffSet < - kHeaderHeight) {
        CGRect frame = _imageView.frame;
        frame.origin.y = yOffSet;
        frame.size.height = -yOffSet;
        frame.origin.x = xOffSet;
        frame.size.width = ScreenWidth + fabs(xOffSet)*2;
        _imageView.frame = frame;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
        static NSString *identifier=@"placeDetail";
       PlaceDetailCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
        
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PlaceDetailCell" owner:self options:nil]lastObject];
            cell.name.text=self.model.name;
            [cell.startView setStarValue:[self.model.rating floatValue]];
            cell.des.text=self.model.recommended_reason;
            cell.gone.text=[NSString stringWithFormat:@"%@  人去过",self.model.visited_count];
          
                  }
          return cell;

    }else if(indexPath.section==1){
        static NSString *identifier=@"Identifier";
       UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.textLabel.text=@"地址";
            cell.detailTextLabel.text=self.model.address;
            cell.detailTextLabel.numberOfLines=0;
           
        }
        return cell;
    }else if (indexPath.section==2){
        static NSString *identifier=@"Identifier";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.textLabel.text=@"概况";
            cell.detailTextLabel.text=self.model.des;
            cell.detailTextLabel.numberOfLines=0;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        }
        return cell;
    }
    else if (indexPath.section==3){
        static NSString *identifier=@"Identifier";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.textLabel.text=@"到达方式";
            cell.detailTextLabel.text=self.model.arrive;
            cell.detailTextLabel.numberOfLines=0;
           
        }
    
        return cell;

        
    }else if (indexPath.section==4){
        static NSString *identifier=@"Identifier";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.textLabel.text=@"开放时间";
            cell.detailTextLabel.text=self.model.openTime;
            cell.detailTextLabel.numberOfLines=0;
            
        }
        return cell;

        
    }else if(indexPath.section==5){
        static NSString *identifier=@"Identifier";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.textLabel.text=@"联系方式";
            cell.detailTextLabel.text=self.model.tel;
            cell.detailTextLabel.numberOfLines=0;
            
        }
        return cell;

        
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 146;
    }
    if (indexPath.section==2) {
        NSDictionary * attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        CGRect textRect = [self.model.des boundingRectWithSize:CGSizeMake(_tableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil];
        return textRect.size.height+60;
    }
    if (indexPath.section==3) {
       
        CGRect textRect = [self.model.arrive boundingRectWithSize:CGSizeMake(_tableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
        return textRect.size.height+60;
    }
    if (indexPath.section==4) {
        
        CGRect textRect = [self.model.openTime boundingRectWithSize:CGSizeMake(_tableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
        return textRect.size.height+60;
    }
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
 
    //需测试 系统电话功能
//    if (indexPath.section==5) {
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.tel]]];
//    }
    if (indexPath.section==1) {
        double longitude=[self.model.lng doubleValue];
        double latitude=[self.model.lat doubleValue];
        MapViewController *map=[[MapViewController alloc]init];
        map.longitude=longitude;
        map.latitude=latitude;
        map.address=self.model.address;
        [self presentViewController:map animated:NO completion:nil];
    }
}



@end
