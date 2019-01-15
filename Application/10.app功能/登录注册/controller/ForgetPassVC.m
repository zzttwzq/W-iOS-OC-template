//
//  ForgetPassVC.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "ForgetPassVC.h"

@interface ForgetPassVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *telInput;
@property (nonatomic,strong) UITextField *yanzma;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *repassword;
@property (nonatomic,strong) UIButton *loginBtn;

@end

@implementation ForgetPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"更新密码";
    self.view.backgroundColor = [UIColor whiteColor];

    //================== 手机号输入 ==================
    _telInput = [UITextField textfiledWithLeftImage:@"手机"];
    _telInput.top = Height_NavBar+30;
    _telInput.delegate = self;
    [_telInput addTarget:self action:@selector(telDidChange:) forControlEvents:UIControlEventEditingChanged];
    _telInput.placeholder = @"请输入手机号码";
    _telInput.keyboardType = UIKeyboardTypeNumberPad;
    if (CurrentUser.mobile.length > 0) {
        _telInput.text = CurrentUser.mobile;
    }
    [self.view addSubview:_telInput];

    //================== 验证码输入 ==================
    _yanzma = [UITextField textfiledWithLeftImage:@"短信"
                                        rightText:@"发送验证码"
                                        sendClick:^(UIButton * _Nonnull sender) {

                                            [UserLogic sendSms:self.telInput.text phoneType:UserCodeType_Registed sender:sender];
                                        }];
    _yanzma.top = _telInput.bottom+30;
    _yanzma.delegate = self;
    [_yanzma addTarget:self action:@selector(yanzhenDidChanged:) forControlEvents:UIControlEventEditingChanged];
    _yanzma.placeholder = @"请输入验证码";
    _yanzma.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_yanzma];

    //================== 密码 ==================
    _password = [UITextField textfiledWithLeftImage:@"密码"];
    _password.top = _yanzma.bottom+30;
    //    _password.delegate = self;
    [_password addTarget:self action:@selector(passDidChange:) forControlEvents:UIControlEventEditingChanged];
    _password.placeholder = @"请输入密码";
    _password.secureTextEntry = YES;
    [self.view addSubview:_password];

    //================== 重新输入密码 ==================
    _repassword = [UITextField textfiledWithLeftImage:@"密码"];
    _repassword.top = _password.bottom+30;
        //    _repassword.delegate = self;
    [_repassword addTarget:self action:@selector(repassDidChange:) forControlEvents:UIControlEventEditingChanged];
    _repassword.placeholder = @"请重新输入密码";
    _repassword.secureTextEntry = YES;
    [self.view addSubview:_repassword];

    _loginBtn = [UIButton buttonWithTitle:@"更新密码" backColor:Botton_Disable_Color titleColor:nil];
    _loginBtn.top = _repassword.bottom+60;
    [_loginBtn addTarget:self action:@selector(registerclick) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.enabled = NO;
    [self.view addSubview:_loginBtn];
}

- (void) telDidChange:(UITextField *)text
{
    if (text.text.length > 11) {

        text.text = [text.text substringToIndex:11];
    }

    [self checkLoginBtnState];
}

- (void) yanzhenDidChanged:(UITextField *)text
{
    if (text.text.length > 6) {

        text.text = [text.text substringToIndex:6];
    }

    [self checkLoginBtnState];
}

- (void) passDidChange:(UITextField *)text
{
    if (text.text.length > 20) {

        text.text = [text.text substringToIndex:20];
    }

    [self checkLoginBtnState];
}

- (void) repassDidChange:(UITextField *)text
{
    if (text.text.length > 20) {

        text.text = [text.text substringToIndex:20];
    }

    [self checkLoginBtnState];
}

- (void) checkLoginBtnState
{
    if (_telInput.text.length == 11 &&
        _yanzma.text.length == 6 &&
        _password.text.length <= 20 &&
        _password.text.length >= 6 &&
        _repassword.text.length <= 20 &&
        _repassword.text.length >= 6) {

        self.loginBtn.enabled = YES;
        [_loginBtn setBackgroundColor:Botton_Color];
    }
    else{

        self.loginBtn.enabled = NO;
        [_loginBtn setBackgroundColor:Botton_Disable_Color];
    }
}

- (void) registerclick
{
    if (_telInput.text.length == 0) {

        SHOW_ERROR_MESSAGE(@"请输入手机号");
    }
    else if (_telInput.text.length != 11) {

        SHOW_ERROR_MESSAGE(@"手机号位数不正确");
    }
    else if (_yanzma.text.length == 0) {

        SHOW_ERROR_MESSAGE(@"请输入验证码");
    }
    else if (_yanzma.text.length != 6) {

        SHOW_ERROR_MESSAGE(@"验证码位数不正确");
    }
    else if (_password.text.length == 0) {

        SHOW_ERROR_MESSAGE(@"请输入密码");
    }
    else if (_password.text.length < 6 ||
             _password.text.length > 20) {

        SHOW_ERROR_MESSAGE(@"密码位数不正确");
    }
    else if (![_password.text isEqualToString:_repassword.text]) {

        SHOW_ERROR_MESSAGE(@"两次输入的密码不一致");
    }
    else{

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.telInput.text forKey:@"mobile"];
        [params setValue:self.yanzma.text forKey:@"code"];
        [params setValue:self.password.text forKey:@"password"];

        [UserLogic forgetUserPassWordWithParams:params callBack:^{

            if (self.isUpdatePass) {

                SHOW_SUCCESS_MESSAGE(@"密码修改成功！");

                LOGOUT;
            }
            else{

                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}


@end
