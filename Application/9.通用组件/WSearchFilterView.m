//
//  WSearchFilterView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/22.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WSearchFilterView.h"

@interface WSearchFilterView ()

@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,assign) NSInteger lastIndex;
@property (nonatomic,assign) BOOL asc;

@end


@implementation WSearchFilterView

/**
 初始化

 @param titleArray 排序字段
 @return 返回实例化对象
 */
- (instancetype) initWithTitleArray:(NSArray *)titleArray;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, ScreenWidth, 35);
        self.backgroundColor = [UIColor whiteColor];
        self.titleArray = titleArray;

        float cellWidth = ScreenWidth/self.titleArray.count;
        for (int i = 0; i<self.titleArray.count; i++) {

            UIView *cellBack = VIEW_WITH_RECT(cellWidth*i, 0, cellWidth, self.height);
            [self addSubview:cellBack];

            UILabel *title = LABEL_WITH_RECT(0, 0, cellWidth, cellBack.height);
            title.textAlignment = NSTextAlignmentCenter;
            title.font = Normal_Font;
            title.textColor = Text_Color;
            title.userInteractionEnabled = YES;
            [title addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickItem:)]];
            title.tag = 1000+i;
            title.text = self.titleArray[i];
            [cellBack addSubview:title];

            CGSize size = [title.text sizeWithFont:Normal_Font maxSize:CGSizeMake(cellWidth, self.height)];

            UIImageView *image = IMAGE_WITH_RECT(cellWidth/2+size.width/2+5, (self.height-5)/2, 9, 5);
            image.image = [UIImage imageNamed:@"下"];
            image.tag = 2000+i;
            [cellBack addSubview:image];

            if (i != 0) {
                image.alpha = 0;
            }
        }
    }
    return self;
}

- (void) clickItem:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 1000;

    UIImageView *lastImage = [self viewWithTag:2000+_lastIndex];
    lastImage.alpha = 0;

    UIImageView *images = [self viewWithTag:2000+index];
    images.alpha = 1;

    if (_lastIndex == index) {

        self.asc = !self.asc;
    }
    else{
        self.asc = YES;
    }

    if (!self.asc) {

        images.image = [UIImage imageNamed:@"上"];
    }
    else{

        images.image = [UIImage imageNamed:@"下"];
    }

    _lastIndex = index;

    if ([self.searchDelegate respondsToSelector:@selector(sortWithTag:asc:)]) {
        [self.searchDelegate sortWithTag:self.titleArray[index] asc:self.asc];
    }
}

@end
