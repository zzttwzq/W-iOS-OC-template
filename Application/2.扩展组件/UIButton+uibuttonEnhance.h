//
//  UIButton+uibuttonEnhance.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/18.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (uibuttonEnhance)

- (void)addAction:(ButtonBlock)block;

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *) buttonWithTitle:(NSString *)title
                     backColor:(UIColor *)backColor
                    titleColor:(UIColor * _Nullable)titleColor;

@end

NS_ASSUME_NONNULL_END
