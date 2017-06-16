//
//  ZoomImageView.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/21.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "ZoomImageView.h"

@implementation ZoomImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //1:设置图片的填充模式
        self.contentMode = UIViewContentModeScaleAspectFit;
        //2:开启触摸
        self.userInteractionEnabled = YES;
        //3:添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInImageView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark _fullImageView放大之后，添加的手势 ---缩小
-(void)zoomOutInImageView:(UITapGestureRecognizer *)tap{
    //当缩小的时候，为了防治大图没有加载完成，而用户出发此手势，这个时候_progressView还没有从父视图移除
    if (_progressView.superview != nil) {
        [_progressView removeFromSuperview];
    }
    //缩小
    [UIView animateWithDuration:.35 animations:^{
        //01：滑动视图变成透明
        _scrollView.backgroundColor = [UIColor clearColor];
        //02把放大之后的_fullImageView放到self上
        //之前是[self convertRect:self.bounds toView:_scrollView];
        //再转回来.不转坐标系
        _fullImageView.frame = [self convertRect:self.bounds toView:_scrollView];
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
    }];
}

#pragma mark 当前视图的手势方法 -----------------放大
-(void)zoomInImageView:(UITapGestureRecognizer *)tap{
  //为了防治_scrollview被重复创建
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 1.5;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
#warning 手势添加不能放到if (_scrollView == nil)，放到这个里面之后，手势就没了
    //当scrollView出来之后，在上面添加一个缩小的手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutInImageView:)];
    [_scrollView addGestureRecognizer:tap1];
    //关键的一步：把_scrollView添加到Windown上面
    [self.window addSubview:_scrollView];

    
    _scrollView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    //为了防止被复用，需要重置滑动视图的缩放比例
    [_scrollView setZoomScale:1.0];
    //防止_fullImageView被重复创建
    if (_fullImageView == nil) {
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.backgroundColor = [UIColor clearColor];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_fullImageView];
    }
    
    //重新设置fram以及图片，就放在这里，防止复用
    //在这里需要把当前图片的fram转换成_scrollView坐标系的fram
    _fullImageView.frame = [self convertRect:self.bounds toView:_scrollView];
    //设置放大图片的初始image(没放大（没使用原图时候的image）)
    _fullImageView.image = self.image;
    [UIView animateWithDuration:.35 animations:^{
        //01:设置图片视图的大小
        //放大之后，要知道图片的高度  fh ? fw = h/w
        float fh = _fullImageView.image.size.height/_fullImageView.image.size.width * KscreenWidth;
        //放大后的高度，最小为屏幕的高度
        fh = MAX(KscreenHeight, fh);
        _fullImageView.frame = CGRectMake(0, 0, KscreenWidth, fh);
        //把scrollView的背景颜色变一下
        _scrollView.backgroundColor = [UIColor blackColor];
        //设置_scrollView的contentSize的大小
        _scrollView.contentSize = _fullImageView.size;
    } completion:^(BOOL finished)//在动画执行结束之后，去请求大图
    {
        if (_fullImageUrl.length != 0) {
            [_fullImageView sd_setImageWithURL:[NSURL URLWithString:_fullImageUrl] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                //expectedSize:图片的总字节数
                //receivedSize:已经下载了的字结束
                if (_progressView == nil) {
                    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30, 250, KscreenWidth - 60, 20)];
                }
                [self.window addSubview:_progressView];
                _progressView.progress = (float)receivedSize/expectedSize;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [_progressView removeFromSuperview];
            }];
        }
    }];
}

#pragma mark UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _fullImageView;
}

@end
