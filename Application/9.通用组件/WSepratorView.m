//
//  WSepratorView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/11/21.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WSepratorView.h"

@implementation WSepratorView
/**
 生成一个分割的view，带标题

 @param frame frame
 @param title 标题
 @param font 标题字号
 @param color 标题颜色
 @return 返回view
 */
- (instancetype) initWithFrame:(CGRect)frame
                         title:(NSString *)title
                          font:(UIFont *)font
                         color:(UIColor *)color;
{
    self = [super initWithFrame:frame];
    if (self) {

        _line = VIEW_WITH_RECT(0, (self.height-0.5)/2, self.width, 0.5);
        _line.backgroundColor = color;
        [self addSubview:_line];

        CGSize size = [title sizeWithFont:font maxSize:self.size];
        _label = LABEL_WITH_RECT((self.width-size.width-10)/2, 0, size.width+10, self.height);
        _label.text = title;
        _label.textColor = color;
        _label.font = font;
        _label.backgroundColor = white_Color;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }

    return self;
}

@end
