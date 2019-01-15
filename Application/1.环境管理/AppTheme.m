//
//  AppTheme.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/19.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "AppTheme.h"

@implementation AppTheme

#pragma mark - 字体
+(UIFont *)getFontWithSize:(float)size;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+(UIFont *)getTinFont;
{
    return [self getFontWithSize:10];
}

+(UIFont *)getSmallFont;
{
    return [self getFontWithSize:12];
}

+(UIFont *)getNormalFont;
{
    return [self getFontWithSize:14];
}

+(UIFont *)getLargeFont;
{
    return [self getFontWithSize:16];
}

+(UIFont *)getSuperLargeFont;
{
    return [self getFontWithSize:18];
}


#pragma mark - 颜色

// 导航栏设置
+ (UIColor *) getNavigationBackGroundColor;
{
    return [UIColor whiteColor];
}

+ (UIColor *) getNavigationTitleColor;
{
    return [self getTextNormalColor];
}

//tabbar设置
+ (UIColor *) getTabbarBackGroundColor;
{
    return [UIColor whiteColor];
}

+ (UIColor *) getTabbarTextNormalColor;
{
    return [self getTextDetialColor];
}

+ (UIColor *) getTabbarTextHighLightedColor;
{
    return [self getMainColor];
}


#pragma mark - 页面颜色

+ (UIColor *) getViewBackGroundColor;
{
    return RGB(242, 242, 242);
}

+ (UIColor *) getMainColor;
{
    return COLORWITHHEX(@"FF3B3B");
}

+ (UIColor *) getSecondaryColor;
{
    return COLORWITHHEX(@"FF3B3B");
}

+ (UIColor *) getBottonNormalColor;
{
    return COLORWITHHEX(@"FF3B3B");
}

+ (UIColor *) getBottonDisableColor;
{
    return COLORWITHHEX(@"DDDDDD");
}

+ (UIColor *) getTextNormalColor;
{
    return COLORWITHHEX(@"333333");
}

+ (UIColor *) getTextDetialColor;
{
    return COLORWITHHEX(@"999999");
}

+ (UIColor *) getLineColor;
{
    return RGB(216, 216, 216);
}

+ (UIColor *) getSecondaryLineColor;
{
    return COLORWITHHEX(@"808080");
}

+ (UIColor *) getShadowColor;
{
    return COLORWITHHEX(@"fccdde60");
}

@end
