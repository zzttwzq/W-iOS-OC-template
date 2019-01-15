//
//  WSearchView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/22.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WSearchBarView.h"

@implementation WSearchBarView

- (instancetype) init
{
    self = [super init];
    if (self) {

        float height = IS_IPHONE_X ? 15 : 0;
        float height2 = IS_IPHONE_X ? -10 : 0;

        self.frame = CGRectMake(0, 0, ScreenWidth, Height_NavBar+5+height2);

        _searchText = TEXTFIELD_WITH_RECT(50, 27+height, ScreenWidth-50*2, 30);
        _searchText.backgroundColor = RGB(242, 242, 242);
        _searchText.font = Normal_Font;
        _searchText.textColor = COLORWITHHEX(@"9c9c9c");
        _searchText.leftView = VIEW_WITH_RECT(0, 0, 35, 30);
        _searchText.leftViewMode = UITextFieldViewModeAlways;
        _searchText.placeholder = @"搜索想要的商品";
        _searchText.layer.cornerRadius = 8;
        _searchText.layer.masksToBounds = YES;
        _searchText.delegate = self;
        [self addSubview:_searchText];

        UIImageView *image = IMAGE_WITH_RECT(_searchText.left+10, _searchText.top+7, 16, 16);
        image.image = [UIImage imageNamed:@"搜索"];
        [self addSubview:image];
    }
    return self;
}

- (void) setLeftView:(UIView *)leftView
{
    _leftView = leftView;
    if (_leftView) {

        _searchText.left = _leftView.width;
        _searchText.width = ScreenWidth-_leftView.width-_rightView.width;
        [self addSubview:leftView];
    }
}

- (void) setRightView:(UIView *)rightView
{
    _rightView = rightView;
    if (_rightView) {

        _searchText.left = _leftView.width;
        _searchText.width = ScreenWidth-_leftView.width-_rightView.width;
        [self addSubview:_rightView];
    }
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_disableTextFieldToPush) {

        if ([self.delegate respondsToSelector:@selector(pushView)]) {
            [self.delegate pushView];
        }

        return NO;
    }

    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];

    if ([self.delegate respondsToSelector:@selector(didSearch:)]) {
        [self.delegate didSearch:textField.text];
    }

    return YES;
}


@end
