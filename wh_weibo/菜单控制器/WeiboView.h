//
//  WeiboView.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/20.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiBoModel.h"
#import "WXLabel.h"
//WXlabel
#import "ZoomImageView.h"
@interface WeiboView : UIView<WXLabelDelegate>{
    
    WXLabel *_weibolabel;//微博文本视图
    ZoomImageView *_wbImageView;                     //微博图片:这个图片可能是转发的微博的图片，也可以是自己发的微博的图片
    WXLabel *_repostweiboLabel;//转发微博的文本
    ThemeImageView *_bgImageView; //转发微博的背景图片
}

@property (nonatomic,strong) WeiBoModel *model;


@end
