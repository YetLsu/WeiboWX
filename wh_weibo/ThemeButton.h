//
//  ThemeButton.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

//normal状态下需要设置的图片名字
@property (nonatomic,copy) NSString *imageName;

//highlighted状态下（点击的时候高亮状态下）图片的名字
@property (nonatomic,copy) NSString *highLightedImageName;
@end
