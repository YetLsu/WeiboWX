//
//  leftViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "leftViewController.h"
#import "ThemeLabel.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"
#import "HomeViewController.h"
@interface leftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}
@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ResideMenu
    //清除视图的背景颜色
    self.view.backgroundColor = [UIColor clearColor];
    //初始化数据源
    _dataList = @[@[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差"],@[@"小图",@"大图"]];
   /*
    @[@{@"界面切换效果":@[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差"]},@{@"图片浏览模式":@[@"小图",@"大图"]}];
    */
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 160, KscreenHeight) style:UITableViewStyleGrouped];
    //让tableView往下填充
    _tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
}

#pragma mark UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"leftcellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //获取NSUserdefaults对象
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (indexPath.section == 0)//动画类型
    {
        NSMutableDictionary *dic = [user objectForKey:KDrawAnimationType];
        NSNumber *type = [dic objectForKey:KDrawLeftType];
        if (indexPath.row == [type integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
        {
          cell.accessoryType = UITableViewCellAccessoryNone;
                   }
    }else//图片浏览模式
    {
        //当选择图片的浏览模式的时候，把模式对应的行保存在本地
       NSInteger imageRow =[[[NSUserDefaults standardUserDefaults] objectForKey:KimageScale] integerValue];//可能是0
        //如果KimageScale所对应的没有保存的数值，那么用integerValue读出来可能是0，也有可能是一个很大的负数
        if (imageRow <= 0) {
            imageRow = 0;
        }
        if (indexPath.row == imageRow) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    cell.textLabel.text = [_dataList[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
//给每个组添加一个头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.colorName = @"Group_Text_color";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text =[NSString stringWithFormat:@"    %@",section == 0?@"界面切换效果":@"图片浏览模式"];
    return label;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //界面切换效果
    if (indexPath.section == 0) {
        //改变动画类型
        [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:indexPath.row];
        [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:indexPath.row];
        //保存动画类型
        [[MMExampleDrawerVisualStateManager sharedManager] saveConfig];
    
    }else//图片浏览模式
    {
       //如果之前保存的行与点击的行一样，就无需保存
        NSInteger whichRow = [[[NSUserDefaults standardUserDefaults] objectForKey:KimageScale] integerValue];
        if (indexPath.row != whichRow) {
            [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:KimageScale];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //[_tableView reloadData]; 不建议用
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            
            //就直接拿到homeVC->[tableView reloadData]:通过视图层级拿到homeVC
            UITabBarController *tab =(UITabBarController *) self.mm_drawerController.centerViewController;
            UINavigationController *nav = (UINavigationController *)tab.viewControllers[0];//nav是homeVC所在的导航
            HomeViewController *home = nav.viewControllers[0];
            [home->_tableView reloadData];
        }
    }
    [_tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0f;
}

@end
