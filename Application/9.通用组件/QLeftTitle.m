//
//  QLeftTitle.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/9/30.
//  Copyright © 2018年 FengDing_Ping. All rights reserved.
//

#import "QLeftTitle.h"

#define LeftCellHeight 50
#define LeftCellWidth 100

#define LeftCellBackNormal COLORWITHHEX(@"f7f7f7")
#define LeftCellBackSelected white_Color

#define LeftCellTextNormal Text_Color
#define LeftCellTextSelected Text_Color

@interface QLeftTitle()

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,assign) NSInteger lastIndex;
@property (nonatomic,strong) UIView *indecator;
@end


@implementation QLeftTitle
/**
 初始化页面

 @param yOffset y轴高度
 @return 返回实例化对象
 */
- (instancetype) initWithOffset:(float)yOffset;
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, yOffset, LeftCellWidth, ScreenHeight-yOffset-49-Height_Bottom);
        self.backgroundColor = LeftCellBackNormal;

        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.alwaysBounceVertical = YES;
        [self addSubview:_scroll];

        UIView *line = VIEW_WITH_RECT(self.width-0.5, 0, 0.5, self.height);
        line.backgroundColor = Line_Color;
        [self addSubview:line];
    }
    return self;
}


/**
 设置列表数据

 @param listArray 列表数据
 */
- (void)setListArray:(NSArray *)listArray
{
    _listArray = listArray;

    _lastIndex = 0;
    _scroll.contentSize = CGSizeMake(self.width, listArray.count*LeftCellHeight);

    for (int i = 0; i<_listArray.count; i++) {

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, LeftCellHeight*i, self.width, LeftCellHeight)];
        lab.font = Small_Font;
        if (i == 0) {

            lab.backgroundColor = LeftCellBackSelected;
            lab.textColor = LeftCellTextSelected;
        }
        else{

            lab.backgroundColor = LeftCellBackNormal;
            lab.textColor = LeftCellTextNormal;
        }
        lab.text = _listArray[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.userInteractionEnabled = YES;
        [lab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchItem:)]];
        lab.tag = 2000+i;
//        lab.layer.cornerRadius = 12.5;
//        lab.layer.masksToBounds = YES;
        [_scroll addSubview:lab];

        [lab addLineWithRect:CGRectMake(0, lab.height-0.5, lab.width, 0.5) color:COLORWITHHEX(@"808080")];
    }

    [_scroll bringSubviewToFront:_indecator];
}


/**
 item被点击

 @param tap 传过来的手势
 */
-(void)touchItem:(UITapGestureRecognizer *)tap;
{
    int index = (int)tap.view.tag - 2000;

    [UIView animateWithDuration:0.5 animations:^{

        UILabel *lab2 = [self.scroll viewWithTag:2000+self.lastIndex];
        lab2.textColor = LeftCellTextNormal;
        lab2.backgroundColor = LeftCellBackNormal;

        UILabel *lab = [self.scroll viewWithTag:2000+index];
        lab.textColor = LeftCellTextSelected;
        lab.backgroundColor = LeftCellBackSelected;
    }];

    _lastIndex = index;

    if (_selectIndex) {
        _selectIndex(index);
    }

    [self indecatorAnimation:index];
}


/**
 滚动动画

 @param index 滚动的第几个
 */
-(void)indecatorAnimation:(int)index;
{
    [UIView animateWithDuration:0.5 animations:^{

        if (index < self.listArray.count &&
            index >= 0) {

            self.indecator.top = index*LeftCellHeight;
        }
    }];
}


/**
 设置位置

 @param index 位置编号
 */
-(void)setIndex:(int)index;
{
    if (index < _listArray.count &&
        index >= 0) {

        for (int i = 0; i<self.listArray.count; i++) {

            if (i == index) {

                _lastIndex = i;
                UILabel *lab = [_scroll viewWithTag:2000+i];
                lab.textColor = [UIColor redColor];
                lab.backgroundColor = [UIColor whiteColor];
            }else{

                UILabel *lab2 = [_scroll viewWithTag:2000+i];
                lab2.textColor = [UIColor blueColor];
                lab2.backgroundColor = [UIColor greenColor];
            }
        }
        [self indecatorAnimation:index];
    }
}

@end
