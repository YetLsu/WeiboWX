//
//  ThemeViewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/17.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSDictionary *themeConfig;
}

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"主题选择";
    //tableView的高度，就先不减49，到时再做tabbarView的隐藏
    [self setLeftBackButton];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    themeConfig = [ThemeManeger shareManager]->_themeConfig;
    _dataList = [themeConfig allKeys];//所有主题的名字
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"theme"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"theme"];
    }
    cell.textLabel.text = _dataList [indexPath.row];
    //先拿到当前的主题
    NSString *currentThemeName = [ThemeManeger shareManager].themeName;
    if ([currentThemeName isEqualToString:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        //这个else必须要写
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ThemeManeger shareManager].themeName = _dataList [indexPath.row];
    [_tableView reloadData];
}

@end
