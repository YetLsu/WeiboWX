//
//  WeiBoModel.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "WeiBoModel.h"
#import "PublicClass.h"
#import "RegexKitLite.h"
@implementation WeiBoModel

-(id)initContentWithDic:(NSDictionary *)jsonDic{
//要把没生成映射的字段重新赋值：模型里面的属性字段与这个jsonDic里面的字段不一样
    //调用父类的这个方法，把生成映射的数据先赋值给model的属性
    self = [super initContentWithDic:jsonDic];
    
    //直接在数据源里面改变text
    _text = [PublicClass getPairedFaceImageName:_text];\
    if (self.reWeibo) {
        self.reWeibo.text = [PublicClass getPairedFaceImageName:self.reWeibo.text];
    }
    //事件和来源文本处理
    _created_at = [self getTimeWithWeiboCreate_at:_created_at];
    _source = [self GetSourceWithSourceString:_source];
    //没生成映射的就需要单独拿到Jsondic单独赋值
    if (self) {
        //微博id
        self.weiboId = jsonDic[@"id"];
        //处理作者信息 转发微博
        NSDictionary *userDic = jsonDic[@"user"];
        if (userDic) {
            self.userModel = [[UserModel alloc] initContentWithDic:userDic];
        }
        //转发微博
        if (jsonDic[@"retweeted_status"]) {
            NSDictionary *reDic = jsonDic[@"retweeted_status"];
            self.reWeibo = [[WeiBoModel alloc] initContentWithDic:reDic];
            //拿到被转发微博的作者名 /*为原微博加上作者*/
            NSString *nickName = self.reWeibo.userModel.screen_name;
            NSString *text = [NSString stringWithFormat:@"@%@:%@",nickName,self.reWeibo.text];
            self.reWeibo.text = text;
        }
    }
    return self;
}

//处理来源
-(NSString *)GetSourceWithSourceString:(NSString *)source{
    NSString *regex = @">.+<";//.标示除换行符以外的任意字符 ，＋标示一个或者多个
    NSRange range = [source rangeOfRegex:regex];//去source里面去找，有没有符合regex规则的字符串
    
    //range就是符合这种匹配规则的在原字符串的位置
    if (range.location != NSNotFound) {
        source = [source substringWithRange:NSMakeRange(range.location + 1, range.length -2)];
    }
    return source;
}

- (NSString *)getTimeWithWeiboCreate_at:(NSString *)create_at{
    //Mon Oct 19 15:22:42 +0800 2015
    
    //先把这个字符串变成NSDate
    //把日期转成时间格式化对象
    NSDateFormatter *dataForMatter = [[NSDateFormatter alloc] init];
    //设置格式化的语言
    dataForMatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    dataForMatter.dateFormat = @"EEE MMM dd HH:mm:ss ZZZZ yyyy";
    NSDate *weiboDate = [dataForMatter dateFromString:create_at];
    //比较两个日期的时间差，与现在的时间做比较
    long long time = ABS([weiboDate timeIntervalSinceNow]);
    if (time < 60) {
        return [NSString stringWithFormat:@"%lld秒前",time];
    }else if (time < 60 * 60){
        return [NSString stringWithFormat:@"%lld分钟前",time/60];
    }else if (time < 60 * 60 * 24){
        return [NSString stringWithFormat:@"%lld小时前",time/(60*60)];
    }else if(time < 60 * 60 * 24 * 7){
        return [NSString stringWithFormat:@"%lld天前",time/(60*60 * 24)];
    }else{
        //把日期对象变成一个字符串
        //直接显示日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dataForMatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        dataForMatter.dateFormat = @"MM-dd HH:mm";
        return [dateFormatter stringFromDate:weiboDate];
    }
}


@end
