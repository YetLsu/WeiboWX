//
//  AppDelegate.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "AppDelegate.h"
#import "ThemeImageView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建window
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor clearColor];
    [_window makeKeyAndVisible];
    
    //初始化微博对象
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:KAppKey appSecret:KAppSecretKey appRedirectURI:KRedirectURL andDelegate:self];
    
    // 从偏好设置中 获取信息
    // 当第一次授权登陆成功之后，下次就从本地文件中读取授权信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        // accessToken OAuth 认证的令牌
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        
        // expirationDate 失效日期
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        
        // 用户ID
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    //在window上加一个imageView
    ThemeImageView *imageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) ];
    imageView.imageName = @"mask_bg.jpg";
    [_window addSubview:imageView];
    
      //创建菜单控制器
    MenuViewController *menu = [[MenuViewController alloc] init];
    //这个背景颜色盖住了window
    menu.view.backgroundColor = [UIColor clearColor];
    _window.rootViewController = menu;
    return YES;
}

#pragma mark -SinaWeiboDelegate

// [weibo login]
// 1.授权成功之后调用的协议方法
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    // 需要保存的认证信息
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //在这里应该告诉首页，要去获取数据 让homeVc去调用一个方法，去重新请求首页数据
    //现在是相当于appdelegate让homeVC 去实现方法（重新请求数据）
    //那么 homeVC就是appdelegate的代理 ,那么就应该在拿到homeVC实例化对象的时候，去设置成appdelegate的代理
    //让代理去调用这个方法
    
    if (_delegate && [_delegate respondsToSelector:@selector(getData)]) {
            [_delegate getData];//_delegate = homeVC
        }
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error {
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo {
    
}



@end
