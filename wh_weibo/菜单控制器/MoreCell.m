//
//  MoreCell.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/17.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "MoreCell.h"

@implementation MoreCell

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KThemeNameDidChangeAction object:nil];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化cell的时候设置背景颜色
        [self actionChange];
        //自定义子视图
        [self _initView];
        //去掉cell的选择
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChange) name:KThemeNameDidChangeAction object:nil];
    }
    return self;
}

-(void)_initView{
    _themeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    //依赖图像视图，构造fram
    _themeTextLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(_themeImageView.right + 5, 12, 200, 20)];
    _themeDetailLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(KscreenWidth - 100 -30, 12, 100,20 )];

    _themeTextLabel.font = [UIFont systemFontOfSize:16];
    _themeTextLabel.backgroundColor = [UIColor clearColor];
    //给这个label设置一个颜色的名字，拿着名字去找themeManager拿到颜色
    _themeTextLabel.colorName = @"More_Item_Text_color";
    
    _themeDetailLabel.font = [UIFont systemFontOfSize:16];
    _themeDetailLabel.backgroundColor = [UIColor clearColor];
    _themeDetailLabel.colorName = @"More_Item_Text_color";
    _themeDetailLabel.textAlignment = NSTextAlignmentRight;
    
    //把子视图添加到CELL 上面
    [self.contentView addSubview:_themeImageView];
    [self.contentView addSubview:_themeTextLabel];
    [self.contentView addSubview:_themeDetailLabel];
}

//主题改变，通知回调,改变cell的背景颜色
-(void)actionChange{
    self.backgroundColor = [[ThemeManeger shareManager] getThemeColor:@"More_Item_color"];
}


@end
