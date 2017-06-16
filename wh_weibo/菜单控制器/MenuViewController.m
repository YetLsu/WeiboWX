//
//  MenuViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "MenuViewController.h"
#import "leftViewController.h"
#import "RightViewController.h"
#import "CentreViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //设置菜单控制器左侧视图
    self.leftDrawerViewController = [[leftViewController alloc] init];
    //设置菜单控制器右侧视图
    self.rightDrawerViewController = [[RightViewController alloc] init];
    //设置菜单控制器中间视图
    self.centerViewController = [[CentreViewController alloc] init];
    //设置左右视图的宽度
    self.maximumLeftDrawerWidth = 160;
    self.maximumRightDrawerWidth = 60;
    
    //设置手势的作用范围
    //设置开启的手势
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    //设置关闭的手势
    self.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    
    //配置动画的回调函数
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
    }];//readme这个是第三方给的一个固定配置动画的block
    //设置动画类型
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
     [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
}

@end
