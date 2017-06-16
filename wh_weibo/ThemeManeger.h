//
//  ThemeManeger.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <Foundation/Foundation.h>
//自定义管家类
@interface ThemeManeger : NSObject{
    @public
    NSDictionary *_themeConfig;//用来保存主题的键值对
    NSDictionary *_colorConfig;//用来保存当前主题对应的颜色的字典
}

+(instancetype)shareManager;

//主题名字的属性，当需要改变主题的时候，根据主题名字作为key 去_themeConfig 找相应的主题路径,在这个themeName的setter方面，保存变化的主题，然后发送通知
@property (nonatomic,copy) NSString *themeName;

//根据图片的名字，在当前主题路径下找到相对应的图片
-(UIImage *)getThemeImage:(NSString *)imageName;
//根据颜色的名字，在当前主题路径下找到相对应的颜色
-(UIColor *)getThemeColor:(NSString *)colorName;




@end
