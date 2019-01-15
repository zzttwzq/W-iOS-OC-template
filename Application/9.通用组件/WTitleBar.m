//
//  WTitleBar.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/11/24.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WTitleBar.h"

@interface WTitleBar ()

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,assign) NSInteger lastIndex;
@property (nonatomic,strong) UIView *indecator;
@end

@implementation WTitleBar

/**
 初始化界面

 @param array 初始化的数组
 @param selectIndex 选中第几个
 @return 返回界面
 */
-(instancetype)initWithArray:(NSArray *)array
                 selectIndex:(int)selectIndex;
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 45);
        self.backgroundColor = [UIColor whiteColor];

        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scroll];

        _listArray = array;
        _lastIndex = selectIndex;
        float width = ScreenWidth/4;
        _scroll.contentSize = CGSizeMake(width*array.count, self.height);
        for (int i = 0; i<_listArray.count; i++) {

            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(width*i, 0, width, self.height)];
            lab.font = Normal_Font;
            if (selectIndex == i) {

                lab.textColor = Main_Color;
            }else{

                lab.textColor = Text_Deital_Color;
            }
            lab.text = _listArray[i];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.userInteractionEnabled = YES;
            [lab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchItem:)]];
            lab.tag = 2000+i;
            [_scroll addSubview:lab];
        }
        
        _indecator = [[UIView alloc] initWithFrame:CGRectMake(width*0.1, self.height-2, width*0.8, 2)];
        _indecator.backgroundColor = Main_Color;
        [self addSubview:_indecator];
    }
    return self;
}


/**
 item被点击

 @param tap 传过来的手势
 */
-(void)touchItem:(UITapGestureRecognizer *)tap;
{
    int index = (int)tap.view.tag - 2000;

    UILabel *lab2 = [_scroll viewWithTag:2000+_lastIndex];
    lab2.textColor = Text_Deital_Color;

    UILabel *lab = [_scroll viewWithTag:2000+index];
    lab.textColor = Main_Color;

    _lastIndex = index;

    [self indecatorAnimation:index];

    if (_selectIndex) {
        _selectIndex(index);
    }
}

/**
 设置位置

 @param index 位置编号
 */
-(void)setIndex:(int)index;
{
    for (int i = 0; i<self.listArray.count; i++) {

        if (i == index) {

            _lastIndex = i;
            UILabel *lab = [_scroll viewWithTag:2000+i];
            lab.textColor = Text_Deital_Color;
        }else{

            UILabel *lab2 = [_scroll viewWithTag:2000+i];
            lab2.textColor = Main_Color;
        }
    }

    [self indecatorAnimation:index];
}


/**
 滚动动画

 @param index 滚动的第几个
 */
-(void)indecatorAnimation:(int)index;
{
    [UIView animateWithDuration:0.3 animations:^{

        self.indecator.left = index*ScreenWidth/4+ScreenWidth/4*0.1;
    }];
}

@end
