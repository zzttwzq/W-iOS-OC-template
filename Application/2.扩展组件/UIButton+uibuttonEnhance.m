//
//  UIButton+uibuttonEnhance.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/18.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "UIButton+uibuttonEnhance.h"

@interface UIButton ()

@property (nonatomic,copy) StateBlock block;

@end

@implementation UIButton (uibuttonEnhance)

const static char ActionTag = '\0';

- (void)addAction:(ButtonBlock)block
{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) {
        blockAction(self);
    }
}

+ (UIButton *) buttonWithTitle:(NSString *)title
               backColor:(UIColor *)backColor
              titleColor:(UIColor * _Nullable)titleColor;
{
    UIButton *btn = BUTTON;
    btn.frame = CGRectMake(34, 0, (ScreenWidth-34*2), 45);
    [btn setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    btn.titleLabel.font = Normal_Font;
    btn.layer.cornerRadius = 8;
    btn.backgroundColor = backColor;
    [btn shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];

    return btn;
}

@end
