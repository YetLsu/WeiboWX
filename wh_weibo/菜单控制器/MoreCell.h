//
//  MoreCell.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/17.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLabel.h"
#import "ThemeImageView.h"
@interface MoreCell : UITableViewCell

//图片
@property (nonatomic,strong) ThemeImageView *themeImageView;

//功能Label
@property (nonatomic,strong) ThemeLabel *themeTextLabel;

@property (nonatomic,strong) ThemeLabel *themeDetailLabel;

@end
