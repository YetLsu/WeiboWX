//
//  日志.h
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/14.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//
/**
 第一天
 1:创建应用程序 删除Main.sb ->info.plist文件里面删掉Main 对应的配置信息：默认情况是以这个Main.sb去创建window
 2:删掉test文件夹 在project里面也要删除相应的映射
 3:创建window
 4:创建PCH文件 并且设置文件路径  project -> target ->buildSetting->prefix Header ->工程名/pch文件名.pch
5:倒入资源，倒入skins的时候，中间按钮选择第2个（实例目录）
6:倒入weiboSDK之后，target ->other link flags -> -ObjC(private)
7:倒入mmdraw
8:window -> mmdrawerVC(leftVC,CentreVC:tabbarVc,rightVC)
9:图片名字：导航栏图片名字：mask_titlebar.png
 底部背景图片：mask_navbar
 底部5个按钮图片的名字：@"home_tab_icon_1.png",
 @"home_tab_icon_2.png",
 @"home_tab_icon_3.png",
 @"home_tab_icon_4.png",
 @"home_tab_icon_5.png"
 跟随图片的名字:home_bottom_tab_arrow
 
 10:用画布裁剪导航栏的背景图片:
 10.1:先把原图片按照指定fram生成画布
 10.2:用一个UIimaView的类方法，从画布得到图片 [uiimage imagewithCGimage:(CGimageRef)]
 11:新浪微博的登录：登录相关的必要数据都交给了weibo对象，只需要把kappkey,kappsecret kredirectURL 交给weibo对象
 
 第二天
1: 当改变主题时候，导航栏的图片和文字需要改变，自定义的图片需要改变，label的颜色需要改变，cell上面的图片也会被改变
 
主题切换：典型的一对多
切换主题的时候，需要保存主题在本地
设置cell的选中效果
发送通知
子类化视图（只有系统类只有子类化才具有接受通知的能力）
接收到通知的时候，去根据改变的路径，重新获取图片和颜色
 
三：回顾
 ThemeImageView:为什么要用通知：1:不用每次都拿到被代理对象的实例化。
 2:为什么要把ThemeImageView子类化：需要在每个VC里面去注册通知，把ThemeImageView子类化之后，就不需要在每个vc里面去注册通知，直接在ThemeImageView对象初始化的时候，绑定一个通知
 3:为什么要在子类化的ThemeImageView加一个imageName属性：因为不同界面的imageView的图片
 4:为什么要创建这个单利：ThemeManager:首先只创建这么一个类：如果要用一个类来提供当前主题：必需得有一个字典属性，来保存theme.plist的数据（主题名和主题路径的键值对）：_themeConfig.为什么要用到一个setter方法
 ：用来把当前主题的名字给传过去，作为字典的键值，取出对应的value：主题名称对应的主题路径：所以就在这里发送通知。ThemeImageView接收到通知之后，ThemeImageView要根据最新的通知切换图片，就咬娶到最新的主题路径
 所以：在ThemeManager里面写一个方法，提供主题路径。既然ThemeManager里面实时更新这个主题路径，那么就可以把这个方法改成给他一个图片的名字，返回一个UIimage对象:这就是为什么themeManager里面会有-(UIImage *)getThemeImage:(NSString *)imageName;的原因 为什么会有colorConfig这个属性：因为ThemeManager 有_themeConfig。 为什么要提供一个返回uicolor的方法：因为在themeManager里面直接可以得到r,g,b,直接拼成颜色，返回给Label
 为什么要保存ThemeName:因为下去进来的时候，需要使用上次修改的主题
 
 任务：更多页面以及主题切换
 
 第四天
 json在线解析工具
 www.bejson.com
 最简单的查看:把数据拷贝到框里面，然后点击校验，就可以看到数据的层级
 一层一层点进去的层级：拷贝完校验里面的数据后->json相关->json视图－》把数据连贴到这里，再点击视图
 
 使用正则表达式：导入Regexkilite 导入依赖库 libicucore.dylib
 
 百度：30分钟教你使用正则表达式
 
 第五天:
 01:只有文本视图
 02:只有文本视图以及微博图片
 03:微博文本视图 转发微博文本视图：转发别人的微博，是不能上传图片的（无图片）
 04:微博文本视图 转发微博文本视图：转发别人的微博，转发微博视图
 
 第六天
 XIB:如果用Xib去做，用cell的自适应高度，要结合AutoLayout
 如果是纯代码，先把固定的高度算好。然后在tableView的代理方法里面返回cell的高度的时候
 如果scrollView（tableView）显示内容不全:是tableView的高度设高了\
 
 第七天
 图文混排:1:在tableView的代理方法里面，根据拿到的数据元，算出要显示的数据的高度＋控件的高度＋间隙
 
 2:再降数据显示到控件上，设置间隙 以及具体显示在什么地方
 
 只要有网络请求，就要加上菊花.如果点击按钮，需要加载数据 ,更要加菊花
 
 3刷新，加载
 上拉加载，下拉刷新
 下拉刷新：先删除数据源的数据：[dataArr removeAllObjects];再去请求新的数据
 
 上拉加载:1:之所以要用上啦加载，是一个用户体验的问题：note：一次请求太多数据，耗时，消耗资源
 第八天：
 1：适配大图：tableView 返回cell的高度的代理房里获取图片的高度
 2: imageView的fram需要重新设置
 */