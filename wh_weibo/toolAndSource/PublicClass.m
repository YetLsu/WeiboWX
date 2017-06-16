//
//  PublicClass.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/23.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "PublicClass.h"
#import "RegexKitLite.h"
@implementation PublicClass

+(NSString *)getPairedFaceImageName:(NSString *)text{
   
    //提取出文本里面的[＊＊] 1434离开lll [0-9]{3}:[]约束 用[]表示字符 : \\[\\]
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceArr = [text componentsMatchedByRegex:regex];
    //  faceArr = @[[哈哈]，［嘻嘻］，［老鼠］]
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfig = [NSArray arrayWithContentsOfFile:filePath];
    for (NSString *faceName in faceArr) {
        
        //比如当前被遍历到的是[兔子]
        //通过胃词查找符合条件的元素
        NSString *t = [NSString stringWithFormat:@"self.chs = '%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items =[faceConfig filteredArrayUsingPredicate:predicate];
        if (items.count) {
            NSDictionary *faceItem = items [0];
            //拿到真正图片的名字
            NSString *imageName = faceItem[@"png"];
            
            //构建WXlABEL能够识别的图片的字符串
            NSString *replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            text = [text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
        }
    }

    return text;
}

@end
