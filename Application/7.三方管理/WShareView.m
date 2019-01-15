//
//  WShareView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2019/1/7.
//  Copyright © 2019 FengDing_Ping. All rights reserved.
//

#import "WShareView.h"

@interface WShareView ()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation WShareView

- (instancetype) initWithTitles:(NSArray *)titles
                         images:(NSArray *)images;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = RGBA(0, 0, 0, 0.4);

        _backView = VIEW_WITH_RECT(10, 0, ScreenWidth-20, 40);
        _backView.backgroundColor = white_Color;
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];

        _cancelBtn = BUTTON_WITH_RECT(10, 0, ScreenWidth-20, 40);
        _cancelBtn.backgroundColor = white_Color;
        _cancelBtn.layer.cornerRadius = 5;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:Text_Color forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];

        float cellWidth = _backView.width/5.0;
        float cellHeight = 50;

        for (int i = 0; i<titles.count; i++) {

            UIView *backView = VIEW_WITH_RECT(cellWidth*i, 0, cellWidth, cellHeight);
            [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
            backView.userInteractionEnabled = YES;
            backView.tag = 1000+i;
            [_backView addSubview:backView];

            UIImageView *image = IMAGE_WITH_RECT(0, 0, cellWidth-20, cellWidth-20);
            image.image = IMAGE_NAMED(images[i]);
            image.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:image];

            UILabel *label = LABEL_WITH_RECT(0, image.bottom, cellWidth, 20);
            label.font = Normal_Font;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = Text_Color;
            [backView addSubview:label];
        }

        
    }

    return self;
}

- (void) click
{

}

- (void) tapClick:(UITapGestureRecognizer *)tap
{

}

+ (void) showShareView;
{
    WShareView *share = [WShareView new];

    [KeyWindow addSubview:share];

    [UIView animateWithDuration:0.5 animations:^{

        share.backView.top = ScreenHeight - share.backView.height - 20 - share.cancelBtn.height;
    }];
}

@end
