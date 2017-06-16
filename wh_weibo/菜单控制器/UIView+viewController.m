//
//  UIView+viewController.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/21.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "UIView+viewController.h"

@implementation UIView (viewController)
-(UIViewController *)viewController{
    UIResponder *next = self.nextResponder;
    do{
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while (next);//只要next不为nil,就一直递归判断
    
    return (UIViewController *)next;
}

@end
