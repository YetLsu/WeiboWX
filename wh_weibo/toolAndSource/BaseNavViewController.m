//
//  BaseNavViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏不透明
    self.navigationBar.translucent = NO;
    
    [self _initBarAndAttributes];
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_initBarAndAttributes) name:KThemeNameDidChangeAction object:nil];;
    }
    return self;
}

//设置导航栏相关属性
-(void)_initBarAndAttributes{
    
    UIImage *image = [[ThemeManeger shareManager]getThemeImage:@"mask_titlebar.png"];
    //把image按指定fram得到画布
    CGImageRef endImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(10, 10, KscreenWidth, 64));
    image = [UIImage imageWithCGImage:endImageRef];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //释放,否则会造成内存泄漏
    CFRelease(endImageRef);
    
    //设置中间字体的属性
    UIColor *color = [[ThemeManeger shareManager] getThemeColor:@"Mask_Title_color"];
    self.navigationBar.tintColor = color;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};

}


@end
