//
//  WeiboCell.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "WeiboCell.h"
#import "RegexKitLite.h"
@implementation WeiboCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //做控件的初始化
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建单元格视图
        //1:初始化背景视图
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        UIImage *image = [UIImage imageNamed:@"userinfo_shadow_pic.png"];
        _bgImageView.image = [image stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        [self.contentView addSubview:_bgImageView];
        
        //2:初始化用户头像
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userButton.frame = CGRectMake(20, 15, 50, 50);
        //2.1初始化圆角
        _userButton.layer.cornerRadius = 25.0f;
        _userButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_userButton];
        
        //3:初始化昵称
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userButton.right + 10, _userButton.top, 150, 24)];
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:_nickNameLabel];
        
        //4:初始化时间控件
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userButton.right + 10, _nickNameLabel.bottom, 150, 24)];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_timeLabel];
        
        //初始化来源控件
        _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KscreenWidth - 150 - 10 -10, _timeLabel.top, 150, 24)];
        _sourceLabel.textAlignment = NSTextAlignmentRight;
        _sourceLabel.textColor = [UIColor blackColor];
        _sourceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_sourceLabel];
        
        //创建底部按钮
        for (int i =0; i<3; i++) {
            //创建按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;//为了在layoutSubviews拿到button
            //绑定按钮事件
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
        }
        
        //创建weiboView
        _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_weiboView];
    }
    return self;
}


//渲染之前最后的操作 ,在这个时候已经拿到了model
-(void)layoutSubviews{
    [super layoutSubviews];
    //背景视图的fram
    _bgImageView.frame = CGRectMake(10, 5, self.width -20, self.height - 10);
    
    //设置用户头像
    [_userButton sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url] forState:UIControlStateNormal];
    
    //昵称
    _nickNameLabel.text = _model.userModel.screen_name;
    
    //时间
    _timeLabel.text = _model.created_at;
   // NSLog(@"%@",_model.created_at);
    
    //来源
    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    // >来源的内容<

    _sourceLabel.text = _model.source;
    
    //设置按钮的文本和位置 :转发，评论，表态
    NSArray *buttonTitles = @[[NSString stringWithFormat:@"转发:%@",_model.reposts_count],[NSString stringWithFormat:@"评论:%@",_model.comments_count],[NSString stringWithFormat:@"表态:%@",_model.attitudes_count]];
    //按钮的宽度
    float button_width = (self.width - 30)/buttonTitles.count;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:100 + i];
        //设置标题
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        //设置标题颜色
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        //设置Fram
        button.frame = CGRectMake(15 + button_width * i, self.height - 40 -10 , button_width, 40);
    }
    
    //设置_weiboView的fram
    _weiboView.frame = CGRectMake(20, _userButton.bottom + 5, self.width - 40, self.height - 120 + 5);
    _weiboView.model = _model;
    //手动调用_weiboView的layoutSubViews
    [_weiboView setNeedsDisplay];
}

-(void)buttonAction:(UIButton *)button{
    NSLog(@"按钮被点击了");
}




@end
