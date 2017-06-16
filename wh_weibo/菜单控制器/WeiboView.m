//
//  WeiboView.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/20.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "WeiboView.h"
#import "WebViewController.h"
#import "UIView+viewController.h"
#import "DetailViewController.h"
#import "UIView+viewController.h"
@implementation WeiboView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initSubViews];
    }
    return self;
}

//初始化子视图
-(void)_initSubViews{
    //1:微博文本视图
    _weibolabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _weibolabel.backgroundColor = [UIColor clearColor];
    _weibolabel.font = [UIFont systemFontOfSize:14.0];
    _weibolabel.tag = 235;
    _weibolabel.numberOfLines = 0;
    _weibolabel.wxLabelDelegate  = self;
    [self addSubview:_weibolabel];
   
    //2:转发微博的背景图片
    _bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
    _bgImageView.leftHeight = 25.0;
    _bgImageView.topHeight = 25.0;
    _bgImageView.imageName = @"timeline_rt_border_9";
   //此处需要设置背景图片的拉升点
    [self addSubview:_bgImageView];
    
    //转发微博的文本视图
    _repostweiboLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _repostweiboLabel.backgroundColor = [UIColor clearColor];
    _repostweiboLabel.font = [UIFont systemFontOfSize:12.0f];
    _repostweiboLabel.numberOfLines = 0;
    _repostweiboLabel.tag = 226;
    _repostweiboLabel.wxLabelDelegate = self;
    [self addSubview:_repostweiboLabel];
    
    //创建微博图片
    _wbImageView = [[ZoomImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_wbImageView];
}

//现在是有model的
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置微博文本视图的大小和内容
    //设置微博微博内容
    _weibolabel.text = _model.text;
    //算微博文本的高度
//   CGRect rectSize = [_model.text boundingRectWithSize:CGSizeMake(self.width, 2500) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    float wb_height = [WXLabel getAttributedStringHeightWithString:_model.text WidthValue:self.width delegate:self font:_weibolabel.font];//wb_height：计算富文本的高度
    
    _weibolabel.frame = CGRectMake(0, 5, self.width, wb_height);
    
    //判断当前微博有没有转发的微博
    if (_model.reWeibo != nil) //有转发的微博,显示转发微博的文本视图以及转发微博的背景视图
    {
       
        _bgImageView.hidden = NO;
        _repostweiboLabel.hidden = NO;
        
        _repostweiboLabel.text = _model.reWeibo.text;//转发微博文本
        
        float rb_height = [WXLabel getAttributedStringHeightWithString:_model.reWeibo.text WidthValue:self.width delegate:self font:_repostweiboLabel.font];//wb_height：计算富文本的高度
        _repostweiboLabel.frame = CGRectMake(20, _weibolabel.bottom + 10, self.width - 40, rb_height);
        //有转发微博的情况下，就显示转发的微博的原图
        _wbImageView.fullImageUrl = _model.reWeibo.original_pic;
        //有转发微博的情况再去计算有没有图片
        if (_model.reWeibo.bmiddle_pic.length != 0) {
            _wbImageView.hidden = NO;
            //设置图片的Fram
            _wbImageView.frame = CGRectMake(10, _repostweiboLabel.bottom + 10, KLookImageWidth(self.width - 20), KLookImageHeight);
            //给_wbImageView设置图片
            [_wbImageView sd_setImageWithURL:[NSURL URLWithString:_model.reWeibo.bmiddle_pic] placeholderImage:nil];
            
        }else//当前转发微博没有图片
        {
            _wbImageView.hidden = YES;
        }
        //有转发微博的情况，还要给转发的微博设置背景图片Fram
        //背景图片是要包含转发微博的text,还要包含转发微博的图片的高度
        float bg_height = _model.reWeibo.bmiddle_pic.length ==0?(10 + _repostweiboLabel.height + 10) : (10 + _repostweiboLabel.height + 10 +_wbImageView.height + 10);
        //设置背景图片的fram
        _bgImageView.frame = CGRectMake(5, _weibolabel.bottom, self.width - 10, bg_height);
    
    }else//没有转发的微博
    {
    //背景图片需要隐藏，转发微博的文本视图也需要隐藏
        _bgImageView.hidden = YES;
        _repostweiboLabel.hidden = YES;
        //没有转发微博的时候，imageView就显示本微博的图片
        _wbImageView.fullImageUrl = _model.original_pic;
        //判断当前微博是否有图片，如果有则显示，无则隐藏
        if (_model.bmiddle_pic != nil)//有图片
        {
            _wbImageView.hidden = NO;
            //设置图片的大小
            _wbImageView.frame = CGRectMake(0, _weibolabel.bottom + 10, KLookImageWidth(self.width), KLookImageHeight);

            //加载图片
            [_wbImageView sd_setImageWithURL:[NSURL URLWithString:_model.bmiddle_pic] placeholderImage:nil];//placeholderImage图片没有加载出来的时候显示的站位图片
        }else//没有图片
        {
            _wbImageView.hidden = YES;
        }
    }
}

//手指离开当前超链接文本响应的协议方法 :wxLabel：1:原微博的label 2:转发微博文本的Label
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context{
    NSLog(@"手指已经离开的文本");
    if (wxLabel.tag == 235)//点击原微博文本label
    {
        DetailViewController *dtc = [[DetailViewController alloc] init];
        dtc.model = _model;
        //跳转
        [[self viewController] .navigationController pushViewController:dtc animated:YES];
        
    }else if(wxLabel.tag == 226)//点击转发文本label
    {
        DetailViewController *dtc = [[DetailViewController alloc] init];
        dtc.model = _model.reWeibo;
        //跳转
        [[self viewController] .navigationController pushViewController:dtc animated:YES];
    }
}
//手指接触当前超链接文本响应的协议方法
- (void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context{
    NSLog(@"%@",context);
    if ([context hasPrefix:@"http"]) {
        //context：就是点击的网址:可以用一个webView来展示这个网页rb_height 从这个地方跳转到webViewController,传context给webVC，webVC负责显示这个网页
        //递归获取nextResponder :如果nextResponder
        //跳转显示Webview
        WebViewController *wc = [[WebViewController alloc] init];
        wc.title = @"网页链接";
        wc.url = context;
        //得到类型为UIViewController的下一个响应者
        UIViewController *responder = [self viewController];
        [responder.navigationController pushViewController:wc animated:YES];
    }
}

//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
 {
     //设置副文本里面特殊字符串的正则表达式
 //需要添加链接字符串的正则表达式：@用户、http://、#话题#
 NSString *regex1 = @"@\\w+";//字母，或汉子，或下划线
 NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
 NSString *regex3 = @"#\\w+#";
 NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
  return regex;
 
}
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{
    return [UIColor orangeColor];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    return [UIColor greenColor];
}

/*
 注意：
 默认表达式@"<image url = '[a-zA-Z0-9_\\.@%&\\S]*'>"
 可以通过代理方法修改正则表达式，不过本地图片地址的左右（＊＊＊一定要用单引号引起来）
 */
//检索文本中图片的正则表达式的字符串
//- (NSString *)imagesOfRegexStringWithWXLabel:(WXLabel *)wxLabel{
//    
// return @"<image url = '[a-zA-Z0-9_\\.@%&\\S]*'>";
//    
//}


@end
