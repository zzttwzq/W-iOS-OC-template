//
//  LoginVC.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong) WCheckBox *checkBox;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *swichLogin;

@property (nonatomic,strong) UITextField *telInput;
@property (nonatomic,strong) UITextField *pwdInput;

@property (nonatomic,assign) BOOL isSmsLogin;

@end

@implementation LoginVC

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (CurrentUser.token.length == 0) {

        _telInput.text = CurrentUser.mobile;
    }
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = white_Color;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:tap];

    UIImageView *logoImg = IMAGE_WITH_RECT(0, 0, ScreenWidth, IS_IPHONE_X ? 193 : 200);
    [logoImg setImage:[UIImage imageNamed:@"登录header"]];
        //    logoImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoImg];

    if (IS_IPHONE_5) {
        logoImg.height = 50;
        logoImg.image = nil;
    }

    int height = 36;
    if (IS_IPHONE_X) {
        height = 50;
    }

    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(20, height, 18, 18);
    [backBtn setImage:IMAGE_NAMED(@"关闭页面") forState:0];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];


    //==================手机号输入==================
    _telInput = [UITextField textfiledWithLeftImage:@"手机"];
    _telInput.top = logoImg.bottom+30;
    _telInput.delegate = self;
    [_telInput addTarget:self action:@selector(telDidChange:) forControlEvents:UIControlEventEditingChanged];
    _telInput.placeholder = @"请输入手机号码";
    _telInput.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_telInput];


    //==================验证码输入==================
    _pwdInput = [UITextField textfiledWithLeftImage:@"密码"];
    _pwdInput.top = _telInput.bottom+30;
    _pwdInput.delegate = self;
    [_pwdInput addTarget:self action:@selector(pwdDidChanged:) forControlEvents:UIControlEventEditingChanged];
    _pwdInput.placeholder = @"请输入验证码";
    [self.view addSubview:_pwdInput];


    _loginBtn = [UIButton buttonWithTitle:@"登录" backColor:Botton_Disable_Color titleColor:nil];
    _loginBtn.top = _pwdInput.bottom+30;
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.enabled = NO;
    [self.view addSubview:_loginBtn];
    [self swichLoginType];
    [self swichLoginType];


    UIButton *forgetPasses = [[UIButton alloc]init];
    forgetPasses.frame = CGRectMake(30, _loginBtn.bottom+10, 80, 20);
    [forgetPasses addTarget:self action:@selector(forgetPwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasses setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPasses setTitleColor:Text_Color forState:UIControlStateNormal];
    forgetPasses.titleLabel.font = Normal_Font;
    [self.view addSubview:forgetPasses];


    _swichLogin = BUTTON_WITH_RECT(ScreenWidth-104, _loginBtn.bottom+10, 80, 20);
    _swichLogin.userInteractionEnabled = YES;
    [_swichLogin setTitle:@"短信登录" forState:UIControlStateNormal];
    _swichLogin.titleLabel.font = Normal_Font;
    [_swichLogin addTarget:self action:@selector(swichLoginType) forControlEvents:UIControlEventTouchUpInside];
    [_swichLogin setTitleColor:Text_Color forState:UIControlStateNormal];
    [self.view addSubview:_swichLogin];


    UIButton *registerBtn = [[UIButton alloc]init];
    registerBtn.frame = CGRectMake((ScreenWidth-80)/2, _loginBtn.bottom+13, 80, 18);
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"新人注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:Main_Color forState:UIControlStateNormal];
    registerBtn.titleLabel.font = Normal_Font;
    [self.view addSubview:registerBtn];


    _checkBox = [[WCheckBox alloc] initWithTitle:@"我已阅读并同意" imageName:@"check_uncheck" hightlightedImageName:@"check_checked"];
    _checkBox.left = (ScreenWidth-_checkBox.width)/2;
    _checkBox.top = _swichLogin.bottom+40;
    _checkBox.checked = YES;
    [self.view addSubview:_checkBox];


    UILabel *lab2 = LABEL_WITH_RECT(_checkBox.right, _checkBox.top, 0, _checkBox.height);
    lab2.font = Small_Font;
    lab2.textColor = Main_Color;
    lab2.userInteractionEnabled = YES;
    lab2.text = @"《趣分享服务协议》";
    [lab2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreentmentClick)]];
    [self.view addSubview:lab2];


    CGSize size = [@"《趣分享服务协议》" sizeWithFont:Small_Font maxSize:CGSizeMake(ScreenWidth, _checkBox.height)];

    _checkBox.left = (ScreenWidth-_checkBox.width-size.width)/2;
    lab2.text = @"《趣分享服务协议》";
    lab2.width = size.width;
    lab2.left = _checkBox.right;


    WSepratorView *sepview = [[WSepratorView alloc] initWithFrame:CGRectMake(100, lab2.bottom+30, ScreenWidth-200, 30) title:@"第三方登录" font:Small_Font color:Text_Color];
    sepview.line.backgroundColor = Line_Color;
    sepview.label.textColor = Main_Color;
    [self.view addSubview:sepview];

    UIButton *wechatLogin = BUTTON_WITH_RECT((ScreenWidth-59)/2, sepview.bottom+20, 52, 52);
    [wechatLogin setBackgroundImage:IMAGE_NAMED(@"weixin") forState:0];
    [wechatLogin addTarget:self action:@selector(wxLogonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatLogin];
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
    if (_isSmsLogin) {

        if (text.text.length > 6) {
            text.text = [text.text substringToIndex:6];
        }
    }
    else{

        if (text.text.length > 20) {
            text.text = [text.text substringToIndex:20];
        }
    }

    [self checkLoginBtnState];
}

#pragma mark - 处理按钮功能
- (void) backBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [UserLogic gotoHomeView];
}

- (void) forgetPwdBtnAction
{
    ForgetPassVC *vc = [ForgetPassVC new];
    [vc showDismissBtn];
    NavgationVC *nav = [[NavgationVC alloc] initWithRootViewController:vc];

    [self presentViewController:nav animated:YES completion:nil];
}

- (void) registerBtnAction
{
    RegisterVC *vc = [RegisterVC new];
    [vc showDismissBtn];
    NavgationVC *nav = [[NavgationVC alloc] initWithRootViewController:vc];

    [self presentViewController:nav animated:YES completion:nil];
}

- (void) agreentmentClick
{
    QWebVC *web = [QWebVC new];
    web.urlString = USER_AGREEMENT;
    web.showNavBar = YES;
    [web showDismissBtn];
    NavgationVC *navi = [[NavgationVC alloc] initWithRootViewController:web];

    [self presentViewController:navi animated:YES completion:nil];
}

- (void) wxLogonAction
{
    [UserLogic loginWithLoginType:UserLoginType_Weixin params:@{} controller:self complete:^(BOOL state) {

        [UserLogic gotoHomeView];
    }];
}

- (void) swichLoginType
{
    _isSmsLogin = !_isSmsLogin;

    [self checkLoginBtnState];

    _pwdInput.rightView = nil;
    _pwdInput.rightViewMode = UITextFieldViewModeNever;

    UIView *view = VIEW_WITH_RECT(0, 0, 60, 30);

    if (_isSmsLogin) {

        UIButton *btn = BUTTON_WITH_RECT(0, 5, 100, 40);
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn.titleLabel.font = Normal_Font;
        [btn setTitleColor:Main_Color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;

        UIImageView *phoneleft = IMAGE_WITH_RECT(15, 0, 20, 30);
        [phoneleft setImage:[UIImage imageNamed:@"短信"]];
        [view addSubview:phoneleft];

        UIView *line = VIEW_WITH_RECT(phoneleft.right+14, 10, 1, 10);
        line.backgroundColor = Line_Color;
        [view addSubview:line];

        _pwdInput.placeholder = @"请输入验证码";
        _pwdInput.secureTextEntry = NO;
        _pwdInput.rightView = btn;
        _pwdInput.rightViewMode = UITextFieldViewModeAlways;

        [_swichLogin setTitle:@"密码登录" forState:UIControlStateNormal];
    }
    else{

        UIImageView *phoneleft = IMAGE_WITH_RECT(15, 0, 20, 30);
        [phoneleft setImage:[UIImage imageNamed:@"密码"]];
        [view addSubview:phoneleft];

        UIView *line = VIEW_WITH_RECT(phoneleft.right+14, 10, 1, 10);
        line.backgroundColor = Line_Color;
        [view addSubview:line];

        _pwdInput.placeholder = @"请输入密码";
        _pwdInput.secureTextEntry = YES;

        [_swichLogin setTitle:@"短信登录" forState:UIControlStateNormal];
    }

    _pwdInput.leftView = view;
    _pwdInput.leftViewMode = UITextFieldViewModeAlways;
}

- (void) loginBtnAction
{
    if (!self.checkBox.checked) {

        SHOW_ERROR_MESSAGE(@"请先同意趣分享服务协议");
        return ;
    }

    UserLoginType type;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.telInput.text forKey:@"mobile"];

    if (self.isSmsLogin) {

        type = UserLoginType_Sms;
        [dict setValue:self.pwdInput.text forKey:@"code"];
    }
    else{

        type = UserLoginType_Password;
        [dict setValue:self.pwdInput.text forKey:@"pwd"];
    }

    SHOW_LOADING;
    [UserLogic loginWithLoginType:type
                           params:dict
                       controller:self
                         complete:^(BOOL state) {

                         }];
}

- (void) sendCode:(UIButton *)sender
{
    [UserLogic sendSms:self.telInput.text phoneType:UserCodeType_Registed sender:sender];
}

#pragma mark - 其他
- (void) hideKeyboard
{
    [self.view endEditing:YES];
}

- (void) checkLoginBtnState
{
    if (_isSmsLogin) {

        if (_telInput.text.length == 11 &&
            _pwdInput.text.length == 6) {

            self.loginBtn.enabled = YES;
            [_loginBtn setBackgroundColor:Botton_Color];
        }
        else{

            self.loginBtn.enabled = NO;
            [_loginBtn setBackgroundColor:Botton_Disable_Color];
        }
    }
    else{

        if (_telInput.text.length == 11 &&
            _pwdInput.text.length <= 20 &&
            _pwdInput.text.length >= 6) {

            self.loginBtn.enabled = YES;
            [_loginBtn setBackgroundColor:Botton_Color];
        }
        else{

            self.loginBtn.enabled = NO;
            [_loginBtn setBackgroundColor:Botton_Disable_Color];
        }
    }
}

@end
