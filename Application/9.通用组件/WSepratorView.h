//
//  WSepratorView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/11/21.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSepratorView : UIView
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *label;

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

@end

NS_ASSUME_NONNULL_END
