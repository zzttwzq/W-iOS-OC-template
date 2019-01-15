//
//  WCustmNavigationView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/27.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WCustmNavigationView.h"

@interface WCustmNavigationView ();

@property (nonatomic,strong) UIView *backView;

@end

@implementation WCustmNavigationView

- (instancetype) initWithTitle:(NSString *)title;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, ScreenWidth, Height_NavBar);
        self.backgroundColor = COLORWITHHEX(@"FF5555");

        _backView = VIEW_WITH_RECT(0, 0, Height_NavBar, Height_NavBar);
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick)]];
        [self addSubview:_backView];

        _backImage = IMAGE_WITH_RECT(15, (Height_NavBar-20)/2+10, 12, 20);
        _backImage.image = IMAGE_NAMED(@"返回-white");
        _backImage.userInteractionEnabled = YES;
        [_backImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick)]];
        [_backView addSubview:_backImage];

        _titleLabel = LABEL_WITH_RECT(15, _backImage.top, ScreenWidth-30, 20);
        _titleLabel.font = SuperLarge_Font;
        _titleLabel.textColor = white_Color;
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void) backBtnClick
{
    if (_backClick) {
        _backClick();
    }
}

- (void) setShowBackBtn:(BOOL)showBackBtn
{
    _showBackBtn = showBackBtn;
    _backView.alpha = _showBackBtn;
}

@end
