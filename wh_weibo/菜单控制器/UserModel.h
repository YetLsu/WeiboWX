//
//  UserModel.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property (nonatomic,copy) NSString *userId;  //用户的id
@property (nonatomic,copy) NSString *screen_name;  //用户的名字
@property (nonatomic,copy) NSString *location;  //用户所在地
@property (nonatomic,copy) NSString *user_description;  //用户个人描述
@property (nonatomic,copy) NSString *profile_image_url;  //用户头像地址（中图），50×50像素
@property (nonatomic,copy) NSNumber *followers_count; 	//粉丝数
@property (nonatomic,copy) NSNumber *friends_count;	//关注数
@property (nonatomic,copy) NSNumber *statuses_count;  //微博数
@property (nonatomic,copy) NSNumber *favourites_count;   //收藏数

@property (nonatomic,copy) NSString *created_at;  //发表时间
@property (nonatomic,copy) NSString *avatar_hd;  //用户头像地址（高清），高清头像原图
@property (nonatomic,copy) NSNumber *online_status;  //用户的在线状态，0：不在线、1：在线

@property(nonatomic,copy)NSString * gender;             //性别，m：男、f：女、n：未知

@end
