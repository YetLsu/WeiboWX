//
//  ThemeManeger.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "ThemeManeger.h"
#define ThemeName @"KThemeName"
@implementation ThemeManeger
- (instancetype)init{
    self = [super init];
    if (self) {
        //设置一个默认的主题名字
        _themeName = @"猫爷";
        NSString *saveThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:ThemeName];
        if (saveThemeName.length > 0) {
            _themeName = saveThemeName;
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        //保存主题的字典
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        //获取当前主题下面颜色的字典 :获取主题目录
        NSString *Path = [self themePath];
        NSString *colorpath = [Path stringByAppendingPathComponent:@"config.plist"];
        //根据颜色文件的具体路径，拿到数据
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:colorpath];
    }
    return self;
}
+ (instancetype)shareManager{
    static ThemeManeger *manager = nil;
    static dispatch_once_t  token;
    dispatch_once(&token, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

-(void)setThemeName:(NSString *)themeName{
    if (_themeName != themeName) {
        _themeName = [themeName copy];
        //这里是改变主题名字的时候调用的
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:ThemeName];
        //同步保存
        [[NSUserDefaults standardUserDefaults] synchronize];
        //发送通知,子类化控件接受通知后，会改变图片，或者字体颜色
        [[NSNotificationCenter defaultCenter] postNotificationName:KThemeNameDidChangeAction object:nil];
        //重新去获取新目录下面颜色主题的字典
        NSString * mainPath = [self themePath];
        NSString *filePath = [mainPath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
}

//根据图片的名字，在当前主题路径下找到相对应的图片
-(UIImage *)getThemeImage:(NSString *)imageName{
    if (imageName.length == 0) {
        return nil;
    }
    //获取包路径
    NSString *path = [self themePath];
    //拼上图片名字
    NSString *imagePath = [path stringByAppendingPathComponent:imageName];
//    UIImage *image = [UIImage imageNamed:imagePath];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}
//根据颜色的名字，在当前主题路径下找到相对应的颜色
-(UIColor *)getThemeColor:(NSString *)colorName{
    if (colorName.length == 0) {
        return nil;
    }
    //@{@"颜色名字":@{@"r":@"",@"g":@"",@"b":@""}}
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    CGFloat alpha = 0;
    NSNumber *alphaValue = rgbDic[@"alpha"];
    //判断颜色字典里面有没有alpha这个属性，如果有，则得到这个alpha值，如果没有，则使用默认的alpha值
    if (alphaValue == nil) {
        alpha = 1.0;
    }else{
        alpha = [alphaValue floatValue];
    }
    return [UIColor colorWithRed:r/255.0 green:g/255 blue:b/255 alpha:alpha];
}

-(NSString *)themePath{
    //获取包的根目录
    NSString *boundlePath = [[NSBundle mainBundle] resourcePath];
    //根据主题名字，拿到当前的主题目录
    NSString *subpath = [_themeConfig objectForKey:_themeName];
    NSString *mainPath = [boundlePath stringByAppendingPathComponent:subpath];
    return mainPath;
}
@end
