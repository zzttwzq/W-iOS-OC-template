//
//  wCheckBox.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/11/21.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WCheckBox.h"

@interface WCheckBox ()

@property (nonatomic,copy) NSString *uncheckImage;
@property (nonatomic,copy) NSString *checkedImage;

@end

@implementation WCheckBox

/**
 初始化checkbox

 @param title 文字标题
 @param imageName 图片名称
 @param hightlightedImageName 选中图片名称
 @return 返回checkbox
 */
- (instancetype) initWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
         hightlightedImageName:(NSString *)hightlightedImageName;
{
    self = [self init];
    if (self) {

        self.frame = CGRectMake(0, 0, 0, 15);
        self.uncheckImage = imageName;
        self.checkedImage = hightlightedImageName;

        _checkImage = IMAGE_WITH_RECT(0, 0, self.height, self.height);
        _checkImage.image = IMAGE_NAMED(imageName);
        [self addSubview:_checkImage];

        CGSize size = [title sizeWithFont:Small_Font maxSize:CGSizeMake(ScreenWidth, self.height)];

        _title = LABEL_WITH_RECT(_checkImage.right+5, 0, size.width, self.height);
        _title.font = Small_Font;
        _title.text = title;
        _title.textColor = Text_Color;
        [self addSubview:_title];

        self.width = _title.right;

        UIView *touchview = VIEW_WITH_RECT(0, 0, self.width, self.height);
        [touchview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
        [self addSubview:touchview];
    }
    return self;
}

- (void) click
{
    self.checked = !self.checked;
    if (self.checkBoxClick) {
        self.checkBoxClick(self.checked);
    }
}

- (void) setChecked:(BOOL)checked
{
    _checked = checked;

    if (_checked) {
        self.checkImage.image = IMAGE_NAMED(self.checkedImage);
    }
    else{
        self.checkImage.image = IMAGE_NAMED(self.uncheckImage);
    }
}

@end
