//
//  FaceView.m
//  wh_weibo
//
//  Created by 玩火的萌娃 on 15/10/28.
//  Copyright (c) 2015年 玩火的萌娃. All rights reserved.
//

#import "FaceView.h"
//单个表情视图所占的宽度和高度(表情所占的点击的区域大小)
#define item_width (KscreenWidth/7.0)
#define item_height (KscreenWidth/7.0)

//表情的宽高
#define face_width 30.0
#define face_height 30.0


@implementation FaceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //加载数据
        [self _initData];
        
    }
    return self;
}
-(void)_initData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *emoticons = [NSArray arrayWithContentsOfFile:filePath];
    
    //把emoticons里面的数据，通过判断每一页要显示多少个表情，把每页的数据放到一个数组。最后把每页的表情的数组统一加到一个大数组里面_items;
    _items = [NSMutableArray array];
    NSMutableArray *item2d = nil;
    for (int i = 0; i < emoticons.count; i ++) {
        //只要这个item2d没初始化，就把它初始化，初始化之后加到大叔组里面去
        if (item2d == nil || item2d.count == 28) {
            item2d = [NSMutableArray arrayWithCapacity:28];
            [_items addObject:item2d];
        }
        //加表情
        NSDictionary *item = emoticons[i];
        [item2d addObject:item];
    }
    //最后for循环遍历结束之后，就生成一个二维的数组（数组里面包含若干个数组(大数组里面的每一个小数组，对应一页表情面板的所有图片信息)）
    //得到数据之后，当前的宽度是根据表情个数来算的
    self.width = KscreenWidth * _items.count;
    self.height = item_height * 4;
}

//不能手动调用，视图在被渲染的时候，最后系统调用此方法。如果想调用此方法，
//[object setNeedsDisplay]
-(void)drawRect:(CGRect)rect{
 //把图片给画上去
    int row = 0;//标记行
    int colum = 0;//标记列
    for ( int i = 0; i < _items.count ; i ++)//遍历表情数据所在的大数组
    {
        //还要遍历大数组里面的小数组
        NSArray *items2D = _items[i];//取出大数组里面的小数组
        //遍历小数组，因为大数组是用来装小数组，图片信息在小数组里面
        for (int j = 0; j < items2D.count; j ++) {
            //通过下标去小数组里面去表情数据对应的字典
            NSDictionary *item = items2D [j];
            //取到图片的名字
            NSString *imageName = item[@"png"];
            //知道图片之后，可以拿到图片，要把图片显示在具体的位置的话，还需要知道当前图片的fram：（x,y,30,30）
            //计算表情的坐标
            //计算X轴的坐标:拿到当前页的初始坐标 + 图片所在的列 * 图片所占区域的宽度 + （图片所占区域的宽度 - 图片的宽度）/2
            CGFloat x = KscreenWidth * i + colum * item_width + (item_width - face_width)/2;
            CGFloat y = row * item_height + (item_height - face_height)/2;
            //读取图片，然后把图片画上去
            UIImage *image = [UIImage imageNamed:imageName];
            [image drawInRect:CGRectMake(x, y, face_width, face_height)];
            colum ++;
            if (colum % 7 == 0) {
                colum = 0;
                row ++;
            }//遍历完小数组之后到下一个页面之前，row要归零
            if (row == 4) {
                row = 0;
            }
        }
    }
}


@end
