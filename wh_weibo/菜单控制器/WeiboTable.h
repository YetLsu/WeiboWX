//
//  WeiboTable.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTable : UITableView<UITableViewDataSource,UITableViewDelegate>

//如果子类有mutable 那么就用copy

@property (nonatomic,copy) NSMutableArray *data;

@end
