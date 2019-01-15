//
//  UITextField+uitextfildEnhance.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/18.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (uitextfildEnhance)

+ (UITextField *) textfiled;

+ (UITextField *) textfiledWithLeftImage:(NSString *)imageName;

+ (UITextField *) textfiledWithLeftImage:(NSString *)imageName
                               rightText:(NSString *)text
                               sendClick:(void(^)(UIButton *sender))sendClick;

@end

NS_ASSUME_NONNULL_END
