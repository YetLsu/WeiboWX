//
//  ZoomImageView.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/21.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomImageView : UIImageView<UIScrollViewDelegate>{
    UIImageView *_fullImageView;
    UIScrollView *_scrollView;//用来滑动原图的滑动视图
    UIProgressView *_progressView;//显示加载大图进度的进度条
}


//原图的图片的地址
@property (nonatomic,copy) NSString *fullImageUrl;

@end
