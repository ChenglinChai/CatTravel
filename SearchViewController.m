//
//  SearchViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "SubSearchViewController.h"
@interface SearchViewController ()<UIWebViewDelegate,UITextFieldDelegate>{
    
    UIImageView *_imageView;
    UITextField *_text;
    UIView *_listView;
    UIButton *_searchBtn;
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"搜索";
    
    [self createBackView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册键盘将要弹出的提醒
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toShowListView:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘将要消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toHideListView:) name:UIKeyboardWillHideNotification object:nil];
    
}
//键盘显示
-(void)toShowListView:(NSNotification *)notification{
    if (!_listView) {
        
        _listView =[[UIView alloc]initWithFrame:CGRectMake(50, 220, self.view.width-100, 0)];
    _listView.backgroundColor=RGBA(158, 158, 158, 0.5);
    }
    [self.view addSubview:_listView];
    
         [UIView animateWithDuration:1 animations:^{
        
        _text.frame=CGRectMake(45, 160, self.view.width-90, 40);
        _listView.frame=CGRectMake(50, 220, self.view.width-100, 200);
        _searchBtn.frame=CGRectMake(_text.right, _text.top, 40, 40);
        
        [self listAddSubBtn];

        
    } completion:^(BOOL finished) {
   
        
        
    }];
    
    
}

-(void)listAddSubBtn{
    
    NSArray *arry=@[@"西藏",@"云南",@"海南",@"重庆",@"武汉",@"北京",@"桂林",@"厦门",@"西安",@"杭州",@"黄山",@"泰山",@"巴黎",@"伦敦",@"纽约",@"迪拜",@"意大利",@"首尔",@"俄罗斯",@"西班牙"];
    for (int i=0; i<5; i++) {
     for (int j=0; j<4;j++) {
         float width=(_listView.width-10*5)/4;
         float height=(200-15*6)/5;
         UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10+j*(10+width), 10+i*(15+height), width, height)];
         [btn setTitle:arry[j+4*i] forState:UIControlStateNormal];
         btn.backgroundColor=[UIColor clearColor];
         btn.layer.borderWidth=1;
         btn.layer.masksToBounds=YES;
         btn.layer.borderColor=[[UIColor whiteColor]CGColor];
         btn.layer.cornerRadius=10;
         btn.titleLabel.font=[UIFont systemFontOfSize:13];
         btn.tag=100+(j+4*i);
         [btn addTarget:self action:@selector(toNextView:) forControlEvents:UIControlEventTouchUpInside];
         [_listView addSubview:btn];
         
        }
    }
    
}

-(void)toNextView:(UIButton *)button{
    
    SubSearchViewController *sub=[[SubSearchViewController alloc]init];
    sub.text=button.titleLabel.text;
    [self.navigationController pushViewController:sub animated:YES];
    
}
//键盘隐藏
-(void)toHideListView:(NSNotification *)notification{
    
    [UIView animateWithDuration:1 animations:^{
         _text.frame=CGRectMake(45, 220, self.view.width-90, 40);
         //_listView.frame=CGRectMake(50, 280, self.view.width-100, 0);
       _searchBtn.frame=CGRectMake(_text.right, _text.top, 40, 40);
     
        [_listView removeFromSuperview];
    } completion:^(BOOL finished) {
        
        
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)createBackView{
    
    _imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    _imageView.image=[UIImage imageNamed:@"back.jpg"];
    [self.view addSubview:_imageView];
    
    _text=[[UITextField alloc]initWithFrame:CGRectMake(45, 220, self.view.width-90, 40)];
    _text.backgroundColor=[UIColor clearColor];
    _text.layer.borderWidth=1;
    _text.layer.cornerRadius=10;
    _text.layer.borderColor=[[UIColor whiteColor]CGColor];
   // _text.borderStyle=UITextBorderStyleRoundedRect;
     _text.clearButtonMode= UITextFieldViewModeWhileEditing;
     _text.placeholder=@"搜地名，搜景点，搜游记";
     _text.clearsOnBeginEditing=YES;
    _text.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_text];
    [self createRightButton];
    
    
}



-(void)createRightButton{
    _searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(_text.right, _text.top, 40, 40)];
    [_searchBtn setBackgroundImage:[UIImage imageNamed: @"ic_search.png"] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchBtn];
    
}

-(void)buttonClick{
    
    SubSearchViewController *sub=[[SubSearchViewController alloc]init];
    sub.text=_text.text;
   
    [self.navigationController pushViewController:sub animated:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_text resignFirstResponder];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
