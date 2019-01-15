//
//  UITextField+uitextfildEnhance.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/18.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "UITextField+uitextfildEnhance.h"

@implementation UITextField (uitextfildEnhance)

+ (UITextField *) textfiled
{
    UITextField *text = TEXTFIELD;

    UIView *view = VIEW_WITH_RECT(0, 0, 20, 30);

    text.frame = CGRectMake(34, 100, (ScreenWidth-34*2), 45);
    text.backgroundColor = [UIColor whiteColor];
    text.clearButtonMode = UITextFieldViewModeWhileEditing;
    text.font = Large_Font;
    text.textColor = Text_Color;
    text.layer.cornerRadius = 10;
    text.leftView = view;
    text.leftViewMode = UITextFieldViewModeAlways;
    [text shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];

    return text;
}

+ (UITextField *) textfiledWithLeftImage:(NSString *)imageName;
{
    UITextField *text = TEXTFIELD;

    UIView *view = VIEW_WITH_RECT(0, 0, 60, 30);

    UIImageView *phoneleft = IMAGE_WITH_RECT(15, 0, 20, 30);
    [phoneleft setImage:[UIImage imageNamed:imageName]];
    [view addSubview:phoneleft];

    UIView *line = VIEW_WITH_RECT(phoneleft.right+14, 10, 1, 10);
    line.backgroundColor = Line_Color;
    [view addSubview:line];

    text.frame = CGRectMake(34, 100, (ScreenWidth-34*2), 45);
    text.backgroundColor = [UIColor whiteColor];
    text.clearButtonMode = UITextFieldViewModeWhileEditing;
    text.font = Large_Font;
    text.textColor = Text_Color;
    text.layer.cornerRadius = 10;
    text.leftView = view;
    text.leftViewMode = UITextFieldViewModeAlways;
    [text shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];

    return text;
}

+ (UITextField *) textfiledWithLeftImage:(NSString *)imageName
                               rightText:(NSString *)text
                               sendClick:(void(^)(UIButton *sender))sendClick;
{
    UITextField *texts = TEXTFIELD;

    UIButton *btn = BUTTON_WITH_RECT(0, 5, 100, 40);
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.titleLabel.font = Normal_Font;
    [btn setTitleColor:Main_Color forState:UIControlStateNormal];

    __weak typeof(UIButton *)weakbtn = btn;
    [btn addAction:^(UIButton *btn) {

        if (sendClick) {
            sendClick(weakbtn);
        }
    }];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;

    UIView *view = VIEW_WITH_RECT(0, 0, 60, 30);

    UIImageView *phoneleft = IMAGE_WITH_RECT(15, 0, 20, 30);
    [phoneleft setImage:[UIImage imageNamed:@"短信"]];
    [view addSubview:phoneleft];

    UIView *line = VIEW_WITH_RECT(phoneleft.right+14, 10, 1, 10);
    line.backgroundColor = Line_Color;
    [view addSubview:line];

    texts.frame = CGRectMake(34, 100, (ScreenWidth-34*2), 45);
    texts.backgroundColor = [UIColor whiteColor];
    texts.clearButtonMode = UITextFieldViewModeWhileEditing;
    texts.font = Large_Font;
    texts.textColor = Text_Color;
    texts.layer.cornerRadius = 10;
    texts.rightView = btn;
    texts.placeholder = @"请输入验证码";
    texts.leftView = VIEW_WITH_RECT(0, 0, 60, 30);
    texts.leftViewMode = UITextFieldViewModeAlways;
    texts.rightViewMode = UITextFieldViewModeAlways;
    [texts shadowWithColor:Shadow_Color offset:CGSizeMake(5, 10) radius:5];
    texts.leftView = view;
    texts.leftViewMode = UITextFieldViewModeAlways;

    return texts;
}


@end
