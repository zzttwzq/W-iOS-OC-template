//
//  WRoundLabelsView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/19.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WRoundLabelsViewDelegate <NSObject>

- (void) labelClickedWithText:(NSString *)text;

- (void) deleteBtnClick;

@end

@interface WRoundLabelsView : UIView

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIImageView *deleteIcon;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIView *labelBackView;

@property (nonatomic,copy) NSArray *labelArray;
@property (nonatomic,copy) NSArray *labelColorArray;
@property (nonatomic,assign) int maxRowCount;
@property (nonatomic,assign) float maxWidth;
@property (nonatomic,assign) BOOL enableTitleUnderLine;

@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) float borderWith;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textcolor;

@property (nonatomic,weak) id<WRoundLabelsViewDelegate> delegate;

/**
 创建一个带图标，标题的 文字排布view 搜索界面显示热搜榜

 @param title 标题
 @param icon 图标
 @param labelArray 文字数组
 @return view
 */
- (instancetype) initWithTitle:(NSString *)title
                          icon:(NSString *)icon
                    labelArray:(NSArray *)labelArray;

@end

NS_ASSUME_NONNULL_END
