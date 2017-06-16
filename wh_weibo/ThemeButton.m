//
//  ThemeButton.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KThemeNameDidChangeAction object:nil];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //在初始化的时候注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:KThemeNameDidChangeAction object:nil];
    }
    return self;
}

//设置正常状态下的图片
-(void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        _imageName = [imageName copy];
        UIImage *image = [[ThemeManeger shareManager] getThemeImage:_imageName];
        [self setImage:image forState:UIControlStateNormal];
    }
}

-(void)setHighLightedImageName:(NSString *)highLightedImageName{
    if (_highLightedImageName != highLightedImageName) {
        _highLightedImageName = [highLightedImageName copy];
        UIImage *image = [[ThemeManeger shareManager] getThemeImage:_highLightedImageName];
        [self setImage:image forState:UIControlStateHighlighted];
    }
}

//通知回调的方法
-(void)themeChangeAction{
    if (_imageName.length > 0) {
        UIImage *image = [[ThemeManeger shareManager] getThemeImage:_imageName];
        [self setImage:image forState:UIControlStateNormal];
    }
    if (_highLightedImageName.length > 0) {
        UIImage *image = [[ThemeManeger shareManager] getThemeImage:_highLightedImageName];
        [self setImage:image forState:UIControlStateHighlighted];
    }
}

@end
