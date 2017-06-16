//
//  CentreViewController.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeButton.h"
@interface CentreViewController : UITabBarController

//标签背景图片
@property (nonatomic,strong) ThemeImageView *tabBarView;

//标签按钮跟随图片
@property (nonatomic,strong) ThemeImageView *selectedView;
@end
