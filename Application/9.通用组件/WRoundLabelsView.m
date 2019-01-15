//
//  WRoundLabelsView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/19.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WRoundLabelsView.h"

@implementation WRoundLabelsView

/**
 创建一个带图标，标题的 文字排布view 搜索界面显示热搜榜

 @param title 标题
 @param icon 图标
 @param labelArray 文字数组
 @return view
 */
- (instancetype) initWithTitle:(NSString *)title
                          icon:(NSString *)icon
                    labelArray:(NSArray *)labelArray;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, ScreenWidth, 0);
        self.layer.masksToBounds = YES;

        //图标
        self.icon = IMAGE_WITH_RECT(15, 10, 15, 15);
        self.icon.image = IMAGE_NAMED(icon);
        [self addSubview:self.icon];

        //标题
        self.title = LABEL_WITH_RECT(self.icon.right+5, self.icon.top, 100, 15);
        self.title.font = Small_Font;
        self.title.textColor = Text_Color;
        self.title.text = title;
        [self addSubview:self.title];

        self.labelArray = labelArray;
    }

    return self;
}

- (instancetype) init
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, ScreenWidth, 15);
        self.layer.masksToBounds = YES;

        //图标
        self.icon = IMAGE_WITH_RECT(15, 10, 15, 15);
        [self addSubview:self.icon];

        //标题
        self.title = LABEL_WITH_RECT(self.icon.right+5, self.icon.top, 100, 15);
        self.title.font = Small_Font;
        self.title.textColor = Text_Color;
        [self addSubview:self.title];

        self.deleteIcon = IMAGE_WITH_RECT(self.width-15, 10, 15, 15);
        self.deleteIcon.userInteractionEnabled = YES;
        [self.deleteIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDelete)]];
        [self addSubview:self.deleteIcon];
    }
    return self;
}

/**
 设置标题数组

 @param labelArray 标题数组
 */
- (void) setLabelArray:(NSArray *)labelArray
{
    _labelArray = labelArray;

    [self.labelBackView removeFromSuperview];

    //文字堆叠view
    self.labelBackView = VIEW_WITH_RECT(0, self.title.bottom, self.width, 0);
    [self addSubview:self.labelBackView];

    float height = 10;

    float totalWidth = 0;
    float totalHeight = height;
    if (!_enableTitleUnderLine) {
        totalHeight = height-10;
    }
    float totalRow = 0;

    if (_enableTitleUnderLine) {

        [self addLineWithRect:CGRectMake(0, self.title.bottom-0.5, self.width, 0.5) color:Line_Color];
    }

    //计算行数
    for (int i = 0; i<labelArray.count; i++) {

        NSString *string = labelArray[i];

        //获取要显示的字的长度
        CGSize size = [string sizeWithFont:Normal_Font maxSize:CGSizeMake(ScreenWidth-20, 27)];
        totalWidth += size.width+30+15;

        //第一次的时候赋予一个长度，避免被挤出去
        if (i == 0) {
            totalHeight += 15;
            totalWidth = size.width+30;
        }

        //如果总长度大于屏幕宽度就累加高度
        if (totalWidth > ScreenWidth-30) {
            totalWidth = size.width+30;
            totalHeight += 15+27;
            totalRow++;

            //总共的行数
            if (totalRow > _maxRowCount-1) {
                break;
            }
        }

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(totalWidth-(size.width+30)+15, totalHeight, size.width+30, 27)];
        lab.layer.borderColor = Line_Color.CGColor;
        lab.layer.cornerRadius = 5;
        lab.layer.borderWidth = 0.5;
        lab.layer.masksToBounds = YES;
        lab.font = Normal_Font;
        lab.textAlignment = NSTextAlignmentCenter;

        if (i < _labelArray.count) {
            lab.textColor = Main_Color;
        }
        else{
            lab.textColor = Text_Color;
        }
        lab.tag = 1000+i;
        lab.text = string;
        lab.backgroundColor = RGB(242, 242, 242);
        
        [lab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTab:)]];
        lab.userInteractionEnabled = YES;

        [self.labelBackView addSubview:lab];
    }

    //底部的线
//    [self addLineWithRect:CGRectMake(0, self.height-0.5, self.width, 0.5) color:Line_Color];

    //view的高度
    if (_labelArray.count != 0) {

        if (_maxRowCount != 0) {

            float addtional = (15+27)*_maxRowCount > (totalHeight + 27) ? (totalHeight + 27) : (15+27)*_maxRowCount;
            self.height = 35 + addtional;
        }
        else{

            self.height = 35 + totalHeight + 27;
        }

        self.labelBackView.height = self.height-35;
    }
    else {

        self.height = 0;
    }
}

- (void) tapDelete
{
    if ([self.delegate respondsToSelector:@selector(deleteBtnClick)]) {
        [self.delegate deleteBtnClick];
    }
}


- (void) selectTab:(UITapGestureRecognizer *)tap
{
    NSString *string;
    if (_labelArray.count > tap.view.tag - 1000) {

        string = _labelArray[tap.view.tag - 1000];
    }

    if ([self.delegate respondsToSelector:@selector(labelClickedWithText:)]) {
        [self.delegate labelClickedWithText:string];
    }
}


/**
 设置最大宽度

 @param maxWidth 最大宽度
 */
- (void) setMaxWidth:(float)maxWidth
{
    _maxWidth = maxWidth;

    self.width = _maxWidth;
    self.deleteIcon.left = self.width-15;
}


/**
 设置lab边框线

 @param borderWith 边框线宽度
 */
- (void) setBorderWith:(float)borderWith
{
    _borderWith = borderWith;

    for (int i = 0; i<_labelColorArray.count; i++) {

        UILabel *label = [self.labelBackView viewWithTag:1000+i];
        label.layer.borderWidth = borderWith;
    }
}


/**
 设置边框颜色

 @param borderColor 边框颜色
 */
- (void) setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;

    for (int i = 0; i<_labelColorArray.count; i++) {

        UILabel *label = [self.labelBackView viewWithTag:1000+i];
        label.layer.borderColor = borderColor.CGColor;
    }
}


/**
 设置标题颜色

 @param labelColorArray 标题颜色数组
 */
- (void) setLabelColorArray:(NSArray *)labelColorArray
{
    _labelColorArray = labelColorArray;

    for (int i = 0; i<_labelColorArray.count; i++) {

        UILabel *label = [self.labelBackView viewWithTag:1000+i];
        label.textColor = _labelColorArray[i];
    }
}


- (void) setTextcolor:(UIColor *)textcolor
{
    _textcolor = textcolor;

    for (int i = 0; i<_labelColorArray.count; i++) {

        UILabel *label = [self.labelBackView viewWithTag:1000+i];
        label.textColor = _textcolor;
    }
}


- (void) setFont:(UIFont *)font
{
    _font = font;

    for (int i = 0; i<_labelColorArray.count; i++) {

        UILabel *label = [self.labelBackView viewWithTag:1000+i];
        label.font = _font;
    }
}

@end
