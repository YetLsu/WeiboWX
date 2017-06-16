//
//  BaseViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
@interface BaseViewController (){
    UIView *_tipView;
    
    MBProgressHUD *_hud;
}


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ThemeImageView *imageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) ];
    imageView.imageName = @"mask_bg.jpg";
    [self.view addSubview:imageView];
}

#pragma mark 自定义菊花
-(void)showJuhua:(BOOL)openFlower{
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.center.y, KscreenWidth, 50)];
        _tipView.backgroundColor = [UIColor blackColor];
        
        //Activity
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityView startAnimating];//让菊花旋转
        
        [_tipView addSubview:activityView];
        
        //提示的label
        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.text = @"正在加载";
        loadLabel.textColor = [UIColor redColor];
        [loadLabel sizeToFit];
        [_tipView addSubview:loadLabel];
        //让loadLabel水平居中显示
        loadLabel.left = (KscreenWidth - loadLabel.width)/2;
        activityView.right = loadLabel.left - 5;
    }
    //网络数据加载完成之后，需要把菊花隐藏
    if (openFlower) {
         [self.view addSubview:_tipView];
    }else{
        [_tipView removeFromSuperview];
    }
}

#pragma mark 用hud自定义菊花
-(void)showHud:(NSString *)title{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    //菊花旁边的文本
    _hud.labelText = title;
    _hud.detailsLabelText = title;
    _hud.detailsLabelFont = [UIFont systemFontOfSize:8.0];
    
    //给菊花后面的视图加一个阴影
    _hud.dimBackground = YES;
    [_hud show:YES];
}

-(void)hideHud:(NSString *)title{
    if (title.length == 0) {
        [_hud hide:YES];
    }
    //如果消失之前还要给出相应的字体提示的话
    else{
        //微信的效果，消失之前出现 _hud.labelText 也出现一个对勾（一张图片）
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
        _hud.mode = MBProgressHUDModeCustomView;
      _hud.labelText = title;
     [_hud hide:YES afterDelay:0.5];
    }
}

-(void)setLeftBackButton{
    ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    button.imageName = @"button_title";
    [button setTitle:@"返回" forState:UIControlStateNormal];
    //可能设置有问题，需要调偏移
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
    [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)leftButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
