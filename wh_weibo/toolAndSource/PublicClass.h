//
//  PublicClass.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/23.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicClass : NSObject

//传一个字符串，再返回一个已经配置好图片文本的字符串
+(NSString *)getPairedFaceImageName:(NSString *)text;

@end
