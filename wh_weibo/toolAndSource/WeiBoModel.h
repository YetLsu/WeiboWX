//
//  WeiBoModel.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
@interface WeiBoModel : BaseModel
@property (nonatomic,copy) NSString *created_at; //微博创建时间
@property (nonatomic,copy) NSString *weiboId; //微博ID
@property (nonatomic,copy) NSString *text; //微博内容
@property (nonatomic,copy) NSString *source; //微博来源

@property (nonatomic,copy) NSNumber *mid; //微博MID
@property (nonatomic,copy) NSString *idstr; //字符串型的微博ID

@property (nonatomic,copy) NSNumber *favorited; //是否已收藏，true：是，false：否
@property (nonatomic,copy) NSNumber *truncated; //是否被截断，true：是，false：否
@property (nonatomic,copy) NSString *in_reply_to_status_id; //（暂未支持）回复ID
@property (nonatomic,copy) NSString *in_reply_to_user_id; //(暂未支持）回复人UID
@property (nonatomic,copy) NSString *in_reply_to_screen_name; //（暂未支持）回复人昵称
@property (nonatomic,copy) NSString *thumbnail_pic; //	缩略图片地址，没有时不返回此字段
@property (nonatomic,copy) NSString *bmiddle_pic;	//中等尺寸图片地址，没有时不返回此字段
@property (nonatomic,copy) NSString *original_pic;	//原始图片地址，没有时不返回此字段
@property (nonatomic,strong) NSDictionary *geo; //地理信息字段 详细

@property (nonatomic,copy) NSNumber *reposts_count; //转发数
@property (nonatomic,copy) NSNumber *comments_count; //评论数
@property (nonatomic,copy) NSNumber *attitudes_count; //表态数
@property (nonatomic,copy) NSNumber *mlevel; //暂未支持

@property (nonatomic,strong) NSArray *pic_urls; //微博配图地址。多图时返回多图链接。无配图返回“[]”

@property (nonatomic, strong) UserModel *userModel;//微博坐着用户的信息字段
@property (nonatomic, strong) WeiBoModel *reWeibo; //被转发的原微博字段信息




@end
