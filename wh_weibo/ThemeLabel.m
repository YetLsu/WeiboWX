//
//  ThemeLabel.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel

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

-(void)setColorName:(NSString *)colorName{
    if (_colorName != colorName) {
        _colorName = [colorName copy];
        UIColor *textColor = [[ThemeManeger shareManager] getThemeColor:_colorName];
        self.textColor = textColor;
    }

}
//接收到主题改变的通知－》改变主题路径－》重新获取_colorName的颜色的r,g,b
-(void)themeChangeAction{
    if (_colorName.length > 0) {
        UIColor *textColor = [[ThemeManeger shareManager] getThemeColor:_colorName];
        self.textColor = textColor;

    }
}


@end
