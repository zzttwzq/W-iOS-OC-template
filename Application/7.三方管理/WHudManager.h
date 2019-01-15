//
//  WHudManager.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/20.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHudManager : NSObject

+ (void) configHUD;

- (void) showToast:(NSString *)toast;

- (void) showErrorIndicatorWithMessage:(NSString *)message;

- (void) showSuccessIndicatorWithMessage:(NSString *)message;

- (void) showInfoIndicatorWithMessage:(NSString *)message;

- (void) showLoading;

- (void) dismissLoading;

- (void) showProgress:(float)progress;

- (void) showHUDWithCustmView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
