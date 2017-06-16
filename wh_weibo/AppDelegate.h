//
//  AppDelegate.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
@protocol GetData <NSObject>

-(void)getData;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) SinaWeibo *sinaweibo;

@property (nonatomic,assign) id <GetData> delegate;

@end

