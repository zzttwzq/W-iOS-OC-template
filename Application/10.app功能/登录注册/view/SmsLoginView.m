//
//  SmsLoginView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "SmsLoginView.h"

@interface SmsLoginView() <UITextFieldDelegate>

@end

@implementation SmsLoginView

/**
 初始化view

 @param xoffset x轴偏移量
 @param showWeixinLoginView 显示三方登录和服务协议
 @return 返回页面
 */
- (instancetype) initWithX:(float)xoffset
       showWeixinLoginView:(BOOL)showWeixinLoginView;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, xoffset, ScreenWidth, 0);

            //==================手机号输入==================
        UIView *view = VIEW_WITH_RECT(0, 0, 60, 30);

        UIImageView *phoneleft = IMAGE_WITH_RECT(15, 0, 30, 30);
        [phoneleft setImage:[UIImage imageNamed:@"手机"]];
        [view addSubview:phoneleft];

        _telInput = TEXTFIELD_WITH_RECT(34, 10, (ScreenWidth-34*2), 45);
        _telInput.delegate = self;
        _telInput.backgroundColor = [UIColor whiteColor];
        _telInput.keyboardType = UIKeyboardTypeNumberPad;
        _telInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        _telInput.font =  Large_Font;
        _telInput.textColor = Text_Deital_Color;
        [_telInput addTarget:self action:@selector(telDidChange:) forControlEvents:UIControlEventEditingChanged];
        _telInput.layer.cornerRadius = 10;
        _telInput.text = CurrentUser.mobile;
        _telInput.leftView = view;
        _telInput.leftViewMode = UITextFieldViewModeAlways;
        _telInput.placeholder = @"请输入手机号码";
        [_telInput shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];
        [self addSubview:_telInput];

            //==================验证码输入==================
        UIButton *btn = BUTTON_WITH_RECT(0, 5, 100, 40);
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn.titleLabel.font = Normal_Font;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = RGB(171, 232, 243);

        _pwdInput = TEXTFIELD
        _pwdInput.frame = _telInput.frame;
        _pwdInput.top = _telInput.bottom+30;
        _pwdInput.delegate = self;
        _pwdInput.leftViewMode = UITextFieldViewModeAlways;
        _pwdInput.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 0)];
        _pwdInput.backgroundColor = [UIColor whiteColor];
        _pwdInput.textAlignment = NSTextAlignmentLeft;
        _pwdInput.font = Large_Font;
        _pwdInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdInput.textColor = Text_Deital_Color;
        [_pwdInput addTarget:self action:@selector(pwdDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _pwdInput.layer.cornerRadius = 10;
        _pwdInput.rightView = btn;
        _pwdInput.rightViewMode = UITextFieldViewModeAlways;
        _pwdInput.placeholder = @"请输入验证码";
        _pwdInput.textAlignment = NSTextAlignmentCenter;
        [_pwdInput shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];
        [self addSubview:_pwdInput];

            //==================邀请码输入==================
        UIView *view3 = VIEW_WITH_RECT(0, 0, 60, 30);

        UIImageView *invitecode3 = IMAGE_WITH_RECT(15, 0, 30, 30);
        [invitecode3 setImage:[UIImage imageNamed:@"邀请码"]];
        [view3 addSubview:invitecode3];

        UILabel *lab = LABEL_WITH_RECT(0, 0, 80, 20);
        lab.textColor = Text_Deital_Color;
        lab.font = Small_Font;
        lab.text = @"非 必 填";

        _inviteCodeInput = TEXTFIELD
        _inviteCodeInput.frame = _pwdInput.frame;
        _inviteCodeInput.top = _pwdInput.bottom+30;
        _inviteCodeInput.delegate = self;
        _inviteCodeInput.leftViewMode = UITextFieldViewModeAlways;
        _inviteCodeInput.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 0)];
        _inviteCodeInput.backgroundColor = [UIColor whiteColor];
        _inviteCodeInput.textAlignment = NSTextAlignmentLeft;
        _inviteCodeInput.font = Large_Font;
        _inviteCodeInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inviteCodeInput.textColor = Text_Deital_Color;
        [_inviteCodeInput addTarget:self action:@selector(inviteCodeDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _inviteCodeInput.layer.cornerRadius = 10;
        _inviteCodeInput.leftView = view3;
        _inviteCodeInput.leftViewMode = UITextFieldViewModeAlways;
        _inviteCodeInput.rightView = lab;
        _inviteCodeInput.rightViewMode = UITextFieldViewModeAlways;
        _inviteCodeInput.placeholder = @"请输入邀请码";
        [_inviteCodeInput shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];
        [self addSubview:_inviteCodeInput];

        self.height = _inviteCodeInput.bottom;
    }
    return self;
}

#pragma makr - 其他事件
- (void) setAgreementText:(NSString *)agreementText
{
    _agreementText = agreementText;

    CGSize size = [_agreementText sizeWithFont:Small_Font maxSize:CGSizeMake(ScreenWidth, _checkBox.height)];

    _checkBox.left = (ScreenWidth-_checkBox.width-size.width)/2;

    UILabel *lab = [self viewWithTag:100];
    lab.text = _agreementText;
    lab.width = size.width;
    lab.left = _checkBox.right;
}

- (void) hideKeyboard
{
    [self endEditing:YES];
}

#pragma mark - 处理输入事件

- (void) telDidChange:(UITextField *)text
{
    if (text.text.length > 11) {
        text.text = [text.text substringToIndex:11];
    }

    [self checkLoginBtnState];
}

- (void) pwdDidChanged:(UITextField *)text
{
    if (text.text.length > 4) {
        text.text = [text.text substringToIndex:4];
    }

    [self checkLoginBtnState];
}

- (void) inviteCodeDidChanged:(UITextField *)text
{
    if (text.text.length > 4) {
        text.text = [text.text substringToIndex:4];
    }

    [self checkLoginBtnState];
}

- (void) checkLoginBtnState
{
    if (_telInput.text.length == 11 &&
        _pwdInput.text.length == 4) {

        self.loginBtn.enabled = YES;
        [_loginBtn setBackgroundColor:Botton_Color];
    }
    else{
        [_loginBtn setBackgroundColor:Botton_Disable_Color];
    }
}

#pragma mark - 处理按钮功能

- (void) agreentmentClick
{
    if (self.agrementClick) {
        self.agrementClick();
    }
}

- (BOOL) checkPhoneNum
{
    if (self.telInput.text.length == 0) {

        SHOW_ERROR_MESSAGE(@"请输入手机号!");
        return NO;
    }
    else if (self.telInput.text.length != 11) {

        SHOW_ERROR_MESSAGE(@"手机号位数不正确!");
        return NO;
    }

    return YES;
}

- (BOOL) checkPwd
{
    if (self.pwdInput.text.length == 0) {

        SHOW_ERROR_MESSAGE(@"请输入验证码!");
        return NO;
    }
    else if (self.pwdInput.text.length < 6 ||
             self.pwdInput.text.length > 20) {

        SHOW_ERROR_MESSAGE(@"验证码位数不正确!");
        return NO;
    }

    return YES;
}

- (BOOL) checkSmsCode
{
    if (self.pwdInput.text.length != 4) {

        SHOW_ERROR_MESSAGE(@"验证码位数不正确!");
        return NO;
    }

    return YES;
}

- (BOOL) checkInviteCode
{
    if (self.pwdInput.text.length != 4) {

        SHOW_ERROR_MESSAGE(@"邀请码位数不正确!");
        return NO;
    }

    return YES;
}

- (void) loginBtnAction
{
    if (![self checkPhoneNum]) {

        return ;
    }

    if (![self sendSMSCode]) {

        return ;
    }

    if (![self checkInviteCode]) {

        return ;
    }

    if (!self.checkBox.checked) {

        SHOW_ERROR_MESSAGE(@"请先同意趣分享服务协议");
        return ;
    }

    if (self.loginBtnClick) {
        self.loginBtnClick(@{
                             @"phone":self.telInput.text,
                             @"yanzhen":self.pwdInput.text,
                             @"inviteCode":self.inviteCodeInput.text,
                             });
    }
}

- (void) sendCode:(UIButton *)sender
{
    if (![self checkPhoneNum]) {

        return ;
    }

    if (self.sendSMSCode) {
        self.sendSMSCode(self.telInput.text);
    }

    __block int timeouts = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeouts<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                [sender setTitleColor:Main_Color forState:UIControlStateNormal];
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }
        else{

            int seconds = timeouts % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{

                [sender setTitleColor:Text_Deital_Color forState:UIControlStateNormal];
                [sender setTitle:[NSString stringWithFormat:@"%@秒后发送",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;

            });
            timeouts--;
        }
    });
    dispatch_resume(_timer);
}

- (void) forgetPwdBtnAction
{

}

- (void) registerBtnAction
{

}

- (void) wxLogonAction
{
    if (self.weixinBtnClick) {
        self.weixinBtnClick();
    }
}

@end
