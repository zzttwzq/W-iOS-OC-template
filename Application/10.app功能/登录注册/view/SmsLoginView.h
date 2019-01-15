//
//  SmsLoginView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCheckBox.h"
#import "WSepratorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SmsLoginView : UIView
//================= 界面 ====================
@property (nonatomic,strong) UITextField *telInput;
@property (nonatomic,strong) UITextField *pwdInput;
@property (nonatomic,strong) UITextField *inviteCodeInput;

@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) WCheckBox *checkBox;
@property (nonatomic,copy) NSString *agreementText;

//================= 回调 ====================
@property (nonatomic,copy) Dict_Block loginBtnClick;
@property (nonatomic,copy) BlankBlock weixinBtnClick;
@property (nonatomic,copy) BlankBlock agrementClick;
@property (nonatomic,copy) StringBlock phoneDidFinishEnter;
@property (nonatomic,copy) StringBlock sendSMSCode;

/**
 初始化view

 @param xoffset x轴偏移量
 @param showWeixinLoginView 显示三方登录和服务协议
 @return 返回页面
 */
- (instancetype) initWithX:(float)xoffset
       showWeixinLoginView:(BOOL)showWeixinLoginView;

@end

NS_ASSUME_NONNULL_END
