//
//  WeiboTable.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/19.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "WeiboTable.h"
#import "WeiBoModel.h"
#import "WeiboCell.h"
#import "WXLabel.h"
#import "DetailViewController.h"
#import "UIView+viewController.h"
@implementation WeiboTable

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //设置代理
        self.delegate = self;
        self.dataSource = self;
        //设置一下tableView 的分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        _data = [NSMutableArray array];
    }
    return self;
}

//整个cell的高度，是在这里设置的
/**
 算出weiboView的高度 ＝ cell 的高度固定的 － 垂直方向控件之间间隙的高度 ＋ 控件的高度
 
 userbutton 与顶部的间隙:15
 userbutton本身的高度     :50
 userbutton距离weiboview底部de间隙:5
 底部按钮距离cell底部的间隙: 10
 底部按钮本身的高度               :  40
 底部按钮距离weiboView底部的间隙 : 5
 */
//在这个方法里面，要知道怎个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiBoModel *model = _data [indexPath.row];
    NSLog(@"%@",model.text);
      CGFloat wb_height = [WXLabel getAttributedStringHeightWithString:model.text WidthValue:KscreenWidth - 40 delegate:nil font:[UIFont systemFontOfSize:14.0f]];
    
    float height = 10;
    //文本的高度
    height += wb_height;
    //判断，当前有没有转发的微博
    if (model.reWeibo)//有转发的微博
    {
        
        CGFloat rb_height = [WXLabel getAttributedStringHeightWithString:model.reWeibo.text WidthValue:KscreenWidth - 40 delegate:nil font:[UIFont systemFontOfSize:12.0f]];

        height += rb_height;
        if (model.reWeibo.bmiddle_pic.length != 0)//如果存在转发图片
        {
            height = height + KLookImageHeight + 10;//10是转发label与转发的imageView的垂直间隙
        }
    }
    else//没有转发的微博
    {
        if (model.bmiddle_pic.length != 0)//判断有没有图片
        {
            height += 10+ KLookImageHeight + 10;
        }
    }
    
    return 125 + height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;//
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell"];
    if (!cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeiboCell"];
    }
    WeiBoModel *model = _data [indexPath.row];
    //bug存在的原因:20条cell还存在，但是数据源早就被清空了
    //需要把数据模型交给cell去显示
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *dtc = [[DetailViewController alloc] init];
    dtc.title = @"微博详情";
    dtc.model = _data[indexPath.row];
    [[self viewController].navigationController pushViewController:dtc animated:YES];
}



@end
