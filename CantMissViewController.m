//
//  CantMissViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CantMissViewController.h"

@interface CantMissViewController ()<UIWebViewDelegate>{
    UIWebView *_webView;
}

@end

@implementation CantMissViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
   }

-(void)initData{
    NSString *url=[NSString stringWithFormat:cantMissURL,self.type,self.idNumber];
   
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    //设置代理
    _webView.delegate=self;
    [self.view addSubview:_webView];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 7, 25, 25)];
    [button setBackgroundImage:[UIImage imageNamed: @"detail_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [_webView addSubview:button];

}
-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString rangeOfString:@"intro"].location != NSNotFound) {
        return YES;
    }
    return NO;
}



@end
