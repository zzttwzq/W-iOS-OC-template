//
//  AppMicro.h
//  aaa
//
//  Created by 吴志强 on 2018/9/12.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#ifndef AppMicro_h
#define AppMicro_h

#import <WBasicLibrary/WBasicHeader.h>
#import <WExpandLibrary/WExpandHeader.h>
#import <WMessage/WToast.h>
#import <WNetwork/WNetwork.h>
#import <WSqlJelly/WSqlTable.h>

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "AppUrls.h"
#import "AppThirdPartyKey.h"
#import "AppTheme.h"
#import "NetworkTool.h"

#import "UserLogic.h"
#import "AppManager.h"
#import "NavgationVC.h"
#import "TabbarVC.h"
#import "WShareMananger.h"
#import "WHudManager.h"
#import "WCustmNavigationView.h"
#import "WRoundLabelsView.h"
#import "WCheckBox.h"
#import "WTitleBar.h"
#import "WSepratorView.h"
#import "WSearchFilterView.h"

#import "QWebVC.h"

#define PLACE_HOLDER_IMAGE [UIImage imageNamed:@"111"]//占位图
#define USER_PLACE_HOLDER_IMAGE [UIImage imageNamed:@"头像_gray"]
#define TEST_USER_ACCOUNT @"13957411081"

#define LOGOUT [CurrentUser logout];


#pragma mark - 字体颜色

#define Tiny_Font [AppTheme getTinFont]
#define Small_Font [AppTheme getSmallFont]
#define Normal_Font [AppTheme getNormalFont]
#define Large_Font [AppTheme getLargeFont]
#define SuperLarge_Font [AppTheme getSuperLargeFont]
#define FontWithSize(A) [AppTheme getFontWithSize:A]


#pragma mark - 导航栏设置

#define Navigation_BackGround_Color [AppTheme getNavigationBackGroundColor]
#define Navigation_BackGround_Image @""
#define Navigation_Title_Color [AppTheme getNavigationTitleColor]
#define Navigation_Title_Font [AppTheme getSuperLargeFont]
#define Navigation_Back_Image_Name @"back"


#pragma mark - tabbar设置

#define Tabbar_BackGround_Color [AppTheme getTabbarBackGroundColor]
#define Tabbar_Text_Normal_Color [AppTheme getTabbarTextNormalColor]
#define Tabbar_Text_HighLighted_Color [AppTheme getTabbarTextHighLightedColor]


#pragma mark - 页面颜色

#define clear_Color [UIColor clearColor]
#define red_Color [UIColor redColor]
#define white_Color [UIColor whiteColor]
#define orange_Color [UIColor orangeColor]
#define yellow_Color [UIColor yellowColor]
#define green_Color [UIColor greenColor]
#define brown_Color [UIColor brownColor]
#define blue_Color [UIColor blueColor]
#define purple_Color [UIColor purpleColor]
#define darkGray_Color [UIColor darkGrayColor]

#define View_Back_Color [AppTheme getViewBackGroundColor]

#define Main_Color [AppTheme getMainColor]
#define Secondary_Color [AppTheme getSecondaryColor]
#define Botton_Color [AppTheme getBottonNormalColor]
#define Botton_Disable_Color [AppTheme getBottonDisableColor]
#define Text_Color [AppTheme getTextNormalColor]
#define Text_Deital_Color [AppTheme getTextDetialColor]
#define Line_Color [AppTheme getLineColor]
#define Line_Secondary_Color [AppTheme getSecondaryLineColor]
#define Shadow_Color [AppTheme getShadowColor]


#pragma mark - 显示消息

#define showToast(_MESSAGE_) [[WHudManager new] showToast:_MESSAGE_];

#define SHOW_SUCCESS_MESSAGE(_MESSAGE_) [[WHudManager new] showSuccessIndicatorWithMessage:_MESSAGE_];
#define SHOW_INFO_MESSAGE(_MESSAGE_)    [[WHudManager new] showInfoIndicatorWithMessage:_MESSAGE_];
#define SHOW_ERROR_MESSAGE(_MESSAGE_)   [[WHudManager new] showErrorIndicatorWithMessage:_MESSAGE_];

#define SHOW_LOADING [[WHudManager new] showLoading];
#define DISMISS_LOADING [[WHudManager new] dismissLoading];
#define SHOW_PROGRESS(A) [[WHudManager new] showProgress:A];
#define SHOW_CUSTMVIEW(A) [[WHudManager new] showHUDWithCustmView:A];

#endif /* AppMicro_h */
