//
//  wCheckBox.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/11/21.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCheckBox : UIView
@property (nonatomic,assign) BOOL checked;
@property (nonatomic,copy) StateBlock checkBoxClick;

@property (nonatomic,strong) UIImageView *checkImage;
@property (nonatomic,strong) UILabel *title;

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

@end

NS_ASSUME_NONNULL_END
