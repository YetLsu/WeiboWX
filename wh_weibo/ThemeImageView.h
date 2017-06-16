//
//  ThemeImageView.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/16.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

//图片名字
@property (nonatomic,copy)NSString *imageName;

//左右拉伸点
@property (nonatomic,assign) CGFloat leftHeight;

@property (nonatomic,assign) CGFloat topHeight;

@end
