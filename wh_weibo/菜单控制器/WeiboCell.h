//
//  WeiboCell.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "WeiboView.h"
@interface WeiboCell : UITableViewCell{
    UIImageView *_bgImageView;//背景视图
    UIButton *_userButton;    //用户头像
    UILabel *_nickNameLabel;  //用户昵称
    UILabel *_timeLabel;      //发布时间
    UILabel *_sourceLabel;    //来源
    WeiboView *_weiboView;       //微博内容视图
}

//通过属性传model ：主流
@property (nonatomic,strong) WeiBoModel *model;

//
//-(void)refreshCellWithModel:(WeiBoModel *)model;

@end
