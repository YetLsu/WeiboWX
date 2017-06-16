//
//  HomeViewController.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTable.h"
@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate>{
    @public
    WeiboTable *_tableView;
}

//这个是常规的公开属性方法
//@property (nonatomic,strong) WeiboTable *tableView;



@end
