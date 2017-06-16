//
//  MessageViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "MessageViewController.h"
#import "WXLabel.h"
#import "RegexKitLite.h"
#import "FaceScrollView.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    FaceScrollView *face = [[FaceScrollView alloc] init];

    face.top = 100;
    [self.view addSubview:face];
   
}


@end
