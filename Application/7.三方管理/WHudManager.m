//
//  WHudManager.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/20.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WHudManager.h"

@implementation WHudManager

+ (void) configHUD;
{
    //键盘配置
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
}

- (void) showToast:(NSString *)toast;
{
    [SVProgressHUD showWithStatus:toast];
}

- (void) showErrorIndicatorWithMessage:(NSString *)message;
{
    [SVProgressHUD showErrorWithStatus:message];
}

- (void) showSuccessIndicatorWithMessage:(NSString *)message;
{
    [SVProgressHUD showSuccessWithStatus:message];
}

- (void) showInfoIndicatorWithMessage:(NSString *)message;
{
    [SVProgressHUD showInfoWithStatus:message];
}

- (void) showLoading;
{
    [SVProgressHUD show];
}

- (void) dismissLoading;
{
    [SVProgressHUD dismiss];
}

- (void) showProgress:(float)progress;
{
    [SVProgressHUD showProgress:progress];
}

- (void) showHUDWithCustmView:(UIView *)view;
{
    [SVProgressHUD show];
}

@end
