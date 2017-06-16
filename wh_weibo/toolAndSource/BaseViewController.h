//
//  BaseViewController.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController

//设置返回按钮的方法
-(void)setLeftBackButton;

//显示加载的提示(菊花)
-(void)showJuhua:(BOOL)openFlower;

//用mb显示菊花
-(void)showHud:(NSString *)title;

//用mb隐藏菊花
-(void)hideHud:(NSString *)title;
@end
