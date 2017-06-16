//
//  FaceScrollView.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/28.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "FaceScrollView.h"

@implementation FaceScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
 }

- (void)_initViews
{
    self.width = KscreenWidth;
    
    //加载表情视图
    _faceView = [[FaceView alloc] initWithFrame:CGRectZero];
    _faceView.backgroundColor = [UIColor clearColor];
    
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, _faceView.height)];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(KscreenWidth * 4, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
   
    [_scrollView addSubview:_faceView];
    [self addSubview:_scrollView];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, KscreenWidth, 20)];
    
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    _pageControl.numberOfPages = 4;
    [self addSubview:_pageControl];
    
    self.height = _scrollView.height + _pageControl.height;
}


#pragma mark -pageControll点击触发方法
- (void)pageAction:(UIPageControl *)page
{
    NSInteger index = page.currentPage;
    
    [_scrollView setContentOffset:CGPointMake(index * KscreenWidth, 0) animated:YES];
    //    _scrollView.contentOffset = CGPointMake(index * kScreenWidth, 0);
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _scrollView.contentOffset.x / KscreenWidth;
    
}
@end
