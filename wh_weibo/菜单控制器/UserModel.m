//
//  UserModel.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        self.userId = jsonDic [@"id"];
        self.user_description = jsonDic [@"description"];
    }
    return self;
}

@end
