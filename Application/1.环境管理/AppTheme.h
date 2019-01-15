//
//  AppTheme.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/19.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppTheme : NSObject

#pragma mark - 字体

+(UIFont *)getTinFont;

+(UIFont *)getSmallFont;

+(UIFont *)getNormalFont;

+(UIFont *)getLargeFont;

+(UIFont *)getSuperLargeFont;

+(UIFont *)getFontWithSize:(float)size;


#pragma mark - 主题颜色

+ (UIColor *) getNavigationBackGroundColor;

+ (UIColor *) getNavigationTitleColor;


+ (UIColor *) getTabbarBackGroundColor;

+ (UIColor *) getTabbarTextNormalColor;

+ (UIColor *) getTabbarTextHighLightedColor;


#pragma mark - 页面颜色

+ (UIColor *) getViewBackGroundColor;

+ (UIColor *) getMainColor;

+ (UIColor *) getSecondaryColor;

+ (UIColor *) getBottonNormalColor;

+ (UIColor *) getBottonDisableColor;

+ (UIColor *) getTextNormalColor;

+ (UIColor *) getTextDetialColor;

+ (UIColor *) getLineColor;

+ (UIColor *) getSecondaryLineColor;

+ (UIColor *) getShadowColor;

@end

NS_ASSUME_NONNULL_END
