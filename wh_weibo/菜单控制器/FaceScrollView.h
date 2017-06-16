//
//  FaceScrollView.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/28.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
@interface FaceScrollView : UIView<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    FaceView *_faceView;
}

@end
