//
//  CentreViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "CentreViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DisCoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavViewController.h"
#import "ThemeManeger.h"
@interface CentreViewController ()<UINavigationControllerDelegate>

@end

@implementation CentreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
        //给tabbar设置子视图
    [self initViews];
    
    //自定义标签栏
    [self _initCustomView];
}

-(void)initViews{
 //创建首页视图
    HomeViewController *home = [[HomeViewController alloc] init];
    AppDelegate *dele =(AppDelegate *)[UIApplication sharedApplication].delegate;
    dele.delegate = home;
#warning 在这里把home设置称为 appdelegate的代理
 //创建消息视图
    MessageViewController *message = [[MessageViewController alloc] init];
 //创建个人中心视图
    ProfileViewController *profile = [[ProfileViewController alloc] init];
 //创建广场视图
    DisCoverViewController *discover = [[DisCoverViewController alloc] init];
 //创建更多视图
    MoreViewController *more = [[MoreViewController alloc] init];
    
    //创建所有视图集合的数组
    NSArray *viewContrls = @[home,message,profile,discover,more];
    //为每一个视图控制器添加一个导航
    NSMutableArray *baseNavArr = [NSMutableArray array];
    for (BaseViewController *vc in viewContrls) {
        //创建导航，把vc设置称为导航的rootVC
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
        nav.delegate = self;
        [baseNavArr addObject:nav];
    }
    self.viewControllers = baseNavArr;
}

-(void)_initCustomView{
//隐藏系统标签栏
    self.tabBar.hidden = YES;
 //添加背景图片
    _tabBarView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, KscreenHeight - 49, KscreenWidth, 49)];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor clearColor];
    //_tabBarView.image = [UIImage imageNamed:@"Skins/bluemoon/mask_navbar.png"];
    _tabBarView.imageName = @"mask_navbar.png";
    [self.view addSubview:_tabBarView];
    
    //创建标签控制器上的选项按钮
    NSArray *imageNames = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png",];
    float width = KscreenWidth/imageNames.count;
    for (int i = 0; i<imageNames.count; i++) {
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *width, 0, width, 49);
        //给按钮设置tag值
        button.tag = i;
        button.imageName = imageNames[i];
        //设置点击事件
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //将按钮添加到背景图片上
        [_tabBarView  addSubview:button];
        //初始化这个跟随的初始位置
        if (0 == i) {
            _selectedView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 65)];
            _selectedView.imageName = @"home_bottom_tab_arrow.png";
            //防止_selectedView拦截 button的点击事件
            [_tabBarView insertSubview:_selectedView atIndex:0];
            //让_selectedView与第一个button中心对齐
            _selectedView.center = button.center;
        }
    }
}

//按钮的点击方法
-(void)buttonAction:(UIButton *)button{
    
  //点击第几个按钮，就切入第几个navigationVC
    self.selectedIndex = button.tag;
  [UIView animateWithDuration:.35 animations:^{
      _selectedView.center = button.center;
  }];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1) {
        self.tabBarView.hidden = NO;
    }else if(navigationController.viewControllers.count == 2){
        self.tabBarView.hidden = YES;
    }
}


@end
