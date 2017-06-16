//
//  WebViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/21.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController (){
    UIWebView *web;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    [self.view addSubview:web];
    web.scrollView.bounces = NO;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}


@end
