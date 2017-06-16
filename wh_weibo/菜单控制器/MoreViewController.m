//
//  MoreViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "ThemeViewController.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    [self _createTable];
    
    [_tableView registerClass:[MoreCell class] forCellReuseIdentifier:@"MoreCell"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_tableView reloadData];
}

-(void)_createTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, KscreenWidth, KscreenHeight- 64) style:UITableViewStyleGrouped];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell"];
    //第0组
    if (indexPath.section == 0) {
        if (indexPath.row == 0)//第一行
        {
            cell.themeImageView.imageName = @"more_icon_theme";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManeger shareManager].themeName;//显示主题名字

        }else//第二行
        {
          cell.themeImageView.imageName = @"more_icon_account";
          cell.themeTextLabel.text = @"账户管理";
        }
    }else if (indexPath.section == 1)//第1组
    {
        cell.themeImageView.imageName = @"more_icon_feedback";
        cell.themeTextLabel.text = @"意见反馈";
    
    }else if (indexPath.section == 2)//第2组
    {
        cell.themeTextLabel.frame = CGRectMake(KscreenWidth/2-200/2, 12, 200, 20);
        cell.themeTextLabel.text = @"注销登录";
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
       cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeViewController *themeVC = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:themeVC animated:YES];
    }
}


@end
