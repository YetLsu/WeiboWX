//
//  DetailViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/24.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentModel.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,SinaWeiboRequestDelegate>{
    UITableView *_tableView;
    UIView * headView;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //给可变数组初始化
    _commentArr = [NSMutableArray array];
    
    //初始化子视图
    [self _initSubViews];
    
    //加载评论数据
    [self loadCommentData];
    
}

-(SinaWeibo *)weibo{
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return dele.sinaweibo;
}


#pragma mark 加载评论数据 --  https://api.weibo.com/2/comments/show.json
-(void)loadCommentData{
    NSMutableDictionary *paras  = [NSMutableDictionary dictionary];
    //[NSString stringWithFormat:@"%@",_model.weiboId]:nsnumber -> nsstring
    //_model.weiboId:(*nsstring) -> nsnumber
    [paras setValue:@"20" forKey:@"count"];
    [paras setObject:[NSString stringWithFormat:@"%@",_model.weiboId] forKey:@"id"];
    [[self weibo] requestWithURL:@"comments/show.json" params:paras  httpMethod:@"GET" delegate:self];
    //数组:(),[] 字典:{},"":""
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *commentArr = dic[@"comments"];
    //遍历comments里面的字典
    for (NSDictionary *commentDic in commentArr) {
        CommentModel *model = [[CommentModel alloc] init];
        model.commentText = commentDic [@"text"];
        //拿到user的字典
        NSDictionary *userDic = commentDic [@"user"];
        model.user = [[UserModel alloc] initContentWithDic:userDic];
        [_commentArr addObject:model];
    }
    [_tableView reloadData];
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{

}
#pragma mark 初始化子视图
-(void)_initSubViews{
    //初始化头视图
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 300)];
    //创建单元格视图
    //2:初始化用户头像
    _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userButton.frame = CGRectMake(20, 15, 50, 50);
    //2.1初始化圆角
    _userButton.layer.cornerRadius = 25.0f;
    _userButton.layer.masksToBounds = YES;
    [_userButton sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url] forState:UIControlStateNormal];
    [headView addSubview:_userButton];
    
    //3:初始化昵称
    _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userButton.right + 10, _userButton.top, 150, 24)];
    _nickNameLabel.textColor = [UIColor blackColor];
    _nickNameLabel.font = [UIFont boldSystemFontOfSize:16.0];
    _nickNameLabel.text = _model.userModel.screen_name;
     [headView addSubview:_nickNameLabel];
    
    //4:初始化时间控件
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userButton.right + 10, _nickNameLabel.bottom, 150, 24)];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.font = [UIFont systemFontOfSize:14.0];
    _timeLabel.text = _model.created_at;
    [headView addSubview:_timeLabel];

    //初始化来源控件
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KscreenWidth - 150 - 10 -10, _timeLabel.top, 150, 24)];
    _sourceLabel.textAlignment = NSTextAlignmentRight;
    _sourceLabel.textColor = [UIColor blackColor];
    _sourceLabel.font = [UIFont systemFontOfSize:14.0];
    _sourceLabel.text = _model.source;
    [headView addSubview:_sourceLabel];
   
    //初始化tableView;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    //去掉空cell
    _tableView.tableFooterView = [[UIView alloc] init];

    //加载weiboView
    //设置_weiboView的fram
     _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    _weiboView.frame = CGRectMake(20, _userButton.bottom + 5, KscreenWidth - 40,[self getWeiboViewHeight]);
    [headView addSubview:_weiboView];
    _weiboView.model = _model;
    //手动调用_weiboView的layoutSubViews
    [_weiboView setNeedsDisplay];
    //设置headView的高度
    headView.height = _weiboView.bottom;//从上往下，最后一个控件的bottom就是headView的高度
    _tableView.tableHeaderView = headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *detailCellID = @"detailCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellID];
    }
    CommentModel *model = _commentArr [indexPath.row];
    cell.textLabel.text = model.commentText;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    //系统cell的情况：如果不加placeholderImage，那么第一次请求图片的时候，要刷新下cell，才会显示图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"liu.png"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)getWeiboViewHeight{
    float height = 10;
    CGFloat wb_height = [WXLabel getAttributedStringHeightWithString:_model.text WidthValue:KscreenWidth - 40 delegate:nil font:[UIFont systemFontOfSize:14.0f]];

    //文本的高度
    height += wb_height;
    //判断，当前有没有转发的微博
    if (_model.reWeibo)//有转发的微博
    {
        
        CGFloat rb_height = [WXLabel getAttributedStringHeightWithString:_model.reWeibo.text WidthValue:KscreenWidth - 40 delegate:nil font:[UIFont systemFontOfSize:12.0f]];
        
        height += rb_height;
        if (_model.reWeibo.bmiddle_pic.length != 0)//如果存在转发图片
        {
            height = height + KLookImageHeight + 10;//10是转发label与转发的imageView的垂直间隙
        }
    }
    else//没有转发的微博
    {
        if (_model.bmiddle_pic.length != 0)//判断有没有图片
        {
            height += 10+ KLookImageHeight + 10;
        }
    }

    return height;
}

@end
