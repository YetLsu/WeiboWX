//
//  HomeViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeButton.h"
#import "WeiBoModel.h"
#import "ThemeImageView.h"
#import "MJRefresh.h"
#import "ThemeLabel.h"
#import <AudioToolbox/AudioToolbox.h>
@interface HomeViewController ()<GetData>{
       SinaWeibo *sinaweibo;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    sinaweibo = [self weibo];
    
       //当isAuthValid为no的时候，就说明，没有验证过，或者验证失败
    //给_tabelView添加传统的下拉刷新
       [self _createTableView];
    __weak HomeViewController *weakHome = self;
    __weak WeiboTable *weakTableView = _tableView;

    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [weakTableView.data removeAllObjects];
        [weakTableView reloadData];
        NSLog(@"下拉刷新了");
        [weakHome getNetData];
    }];
    
    //[_tableView.header endRefreshing]; 收回刷新控件
    
    //下拉刷新，添加gif动画
    //__weak WeiboTable *weakTableView = _tableView;
//    [_tableView addGifHeaderWithRefreshingBlock:^{
//        //下拉刷新,重新加载数据
//        [weakTableView.data removeAllObjects];
//        [weakTableView reloadData];
//        NSLog(@"下拉刷新了");
//        [weakHome getNetData];
////        [weakTableView.header endRefreshing];
//    }];
    
    //初始化图片数组，容纳gif图片
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 1; i<7; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imgs addObject:image];
    }
    //普通状态下的gif ,默认显示的是数组的第一张
  //  [_tableView.gifHeader setImages:imgs forState:MJRefreshHeaderStateIdle];
    
    //处于刷新状态下的gif
    [_tableView.gifHeader setImages:imgs forState:MJRefreshHeaderStateRefreshing];

   
    [self _initNavigationBarButton];
    
    if (sinaweibo.isAuthValid == NO) {
        //验证
        [sinaweibo logIn];
        //执行这句代码的时候，还没有获取认证
    }else{
        [self getNetData];
    }
    //就做上拉加载
    [_tableView addLegendFooterWithRefreshingBlock:^{
        [weakHome _loadMoreData];
    }];
}

#pragma mark getDataDelegate
-(void)getData{
    [self getNetData];
}

//请求新的数据
-(void)_loadMoreData{
    [self showHud:@"给我加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    WeiBoModel *weibo = [_tableView.data lastObject];
    if (weibo == nil) {
        return ;
    }
    NSString *lastID =[NSString stringWithFormat:@"%@",weibo.weiboId];
    [params setObject:lastID forKey:@"since_id"];
    [sinaweibo requestWithURL:@"statuses/home_timeline.json" params:params  httpMethod:@"GET" delegate:self];
}

-(void)getNetData{
    //[self showJuhua:YES]; 自定义的菊花一般不用
    [self showHud:@"给我加载数据"];
    NSDictionary *paras = @{@"count":@"20"};//count:返回微博的个数
    [sinaweibo requestWithURL:@"statuses/home_timeline.json" params:[paras mutableCopy] httpMethod:@"GET" delegate:self];
}

-(void)_createTableView{
    _tableView = [[WeiboTable alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight-49-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}


-(void)changeTheme:(UIButton *)button{
    if (button.tag == 100) {
        [ThemeManeger shareManager].themeName = @"Blue Moon";
    }
    else if (button.tag == 101){
        [ThemeManeger shareManager].themeName = @"Forest";

    }
    else if (button.tag == 102){
        [ThemeManeger shareManager].themeName = @"猫爷";
    }
    button.tag++;
}

-(SinaWeibo *)weibo{
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return dele.sinaweibo;
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
    //[self showJuhua:NO];
    [self hideHud:@"已经加载完成"];
    if (_tableView.header) {
         [_tableView.header endRefreshing];
    }
    if (_tableView.footer) {
         [_tableView.footer endRefreshing];
    }
      NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *weiboDic in jsonDic[@"statuses"]) {
        WeiBoModel *weiboModel = [[WeiBoModel alloc] initContentWithDic:weiboDic];
        [dataArr addObject:weiboModel];
    }
    NSLog(@"dataArr %ld",dataArr.count);
    
    //数据加载完成
    [_tableView.data addObjectsFromArray:dataArr];
    NSLog(@"_table.data %ld",_tableView.data.count);
    [self showNewWeiboCount:dataArr.count];//显示微博数量
    [_tableView reloadData];
}

//显示加载到的微博的个数
-(void)showNewWeiboCount:(NSInteger) count{
    //先假象一个tag值
    ThemeImageView *bageImageView = (ThemeImageView *)[self.view viewWithTag:200];
    if (bageImageView == nil) {
        //首先的位置，藏在导航栏的边缘
        bageImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, 0 - 40, KscreenWidth - 10, 40)];
        bageImageView.tag = 200;
        bageImageView.imageName = @"timeline_notify.png";
        [self.view addSubview:bageImageView];
        
        //创建显示微博数量的文本
        ThemeLabel *bageLabel = [[ThemeLabel alloc] initWithFrame:bageImageView.bounds];
        bageLabel.backgroundColor = [UIColor clearColor];
        bageLabel.textAlignment = NSTextAlignmentCenter;//设置居中对齐
        bageLabel.colorName = @"Timeline_Notice_color";
        bageLabel.tag = 300;
        [bageImageView addSubview:bageLabel];
    }
    //就需要显示数据
    ThemeLabel *bageLabel = (ThemeLabel *)[bageImageView viewWithTag:300];
    NSString *countText = nil;
    if (count > 0)//有微博
    {
        countText = [NSString stringWithFormat:@"有%ld条微博消息",count];
    }else//没有微博
    {
        countText = @"没有微博";
    }
    bageLabel.text = countText;
    //把bageImageView 从边缘显示出来
    //显示动画
    [UIView animateWithDuration:0.8 animations:^{
        //动画:把bageImageView 的微博向下移动
        bageImageView.transform = CGAffineTransformMakeTranslation(0, 40);
        
    } completion:^(BOOL finished) {
        //动画结束之后调用,需要把bageImageView放回原来的位置
        [UIView setAnimationDelay:1.0];//延迟个1秒再回到原来位置
        bageImageView.transform = CGAffineTransformIdentity;
    }];
    
    //搞一个声音提示:播放系统声音 .caf
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:filePath];//http://
    
    //将这个文件注册成为系统声音
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);//执行完这一步，就有了soundID，通过soundID就可以找到对应的系统声音
    //播放系统声音
    AudioServicesPlaySystemSound(soundID);
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{

}

#pragma mark 设置导航栏上面左右两边的按钮
-(void)_initNavigationBarButton{
//左边的按钮
    ThemeButton *leftbutton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    leftbutton.imageName = @"button_title";
    [leftbutton setTitle:@"设置" forState:UIControlStateNormal];
    //可能设置有问题，需要调偏移
    [leftbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
    [leftbutton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
//右边的按钮
    ThemeButton *rightButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    rightButton.imageName = @"button_icon_plus";
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark 导航两边左右按钮的点击事件
//调用控制器打开视图的方法（如果是打开状态，则执行关闭事件）
-(void)leftButtonClick:(UIButton *)button{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];//以后写block调用的时候，要判断传过来的block是不是为nil，如果没判断，别人传的nil,那么会野指针报错
}


-(void)rightButtonClick:(UIButton *)button{
 [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

//在home视图出现的时候，把左右侧滑打开
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //打开mmdraw菜单
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

//在home消失的时候，把左右视图关闭
-(void)viewDidDisappear:(BOOL)animated{
 //关闭mmdraw菜单
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}


@end
