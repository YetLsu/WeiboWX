//
//  DetailViewController.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/24.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
#import "WeiboView.h"
@interface DetailViewController : UIViewController{
 
    UIImageView *_bgImageView;//背景视图
    UIButton *_userButton;    //用户头像
    UILabel *_nickNameLabel;  //用户昵称
    UILabel *_timeLabel;      //发布时间
    UILabel *_sourceLabel;    //来源
    WeiboView *_weiboView;       //微博内容视图

}

//显示详情页面的model :有可能是原微博的model,也有可能是转发微博的model
@property (nonatomic,strong) WeiBoModel *model;

//加载评论的数组
@property (nonatomic,strong) NSMutableArray *commentArr;

@end
