//
//  CommentModel.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/24.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface CommentModel : NSObject

//commentText:评论的内容
@property (nonatomic,copy) NSString *commentText;

//user:评论者的用户model
@property (nonatomic,strong) UserModel *user;

@end
