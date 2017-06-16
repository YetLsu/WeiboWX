//
//  ThemeImageView.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView

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

-(void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        _imageName = [imageName copy];
        UIImage *image = [[ThemeManeger shareManager] getThemeImage:_imageName];
        self.image = image;
    }
}

-(void)setImage:(UIImage *)image{
    if (_leftHeight != 0 || _topHeight != 0 ) {
        UIImage *lastimage = [image stretchableImageWithLeftCapWidth:_leftHeight topCapHeight:_topHeight];
        //拉伸图片之后再设置图片
        [super setImage:lastimage];
    }else
    {
       [super setImage:image];
    }

}

//接收到主题改变的通知
-(void)themeChangeAction{
    if (_imageName.length > 0) {
        UIImage *image = [[ThemeManeger shareManager] getThemeImage:_imageName];
        //这里也需要拉伸图片，因为在切换主题的时候，调用的是这个方法
        self.image = image;
    }
}
@end
