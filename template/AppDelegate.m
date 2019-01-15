//
//  AppDelegate.m
//  qfx
//
//  Created by 吴志强 on 2018/9/27.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "AppDelegate.h"

#import <IQKeyboardManager.h>

#import "WShareMananger.h"
#import "WHudManager.h"
#import "RouterConfig.h"
#import "LocalStorage.h"
#import "NetworkTool.h"
#import "UserLogic.h"

#import "TabbarVC.h"
#import "LoginVC.h"
#import "NavgationVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 配置app 并启动页面
    appLanuchConfig(@"WShareMananger",  //分享管理
                    @"WHudManager",     //三方hud提示配置
                    @"LocalStorage",    //本地存储配置
                    @"RouterConfig",    //路由配置
                    @"NetworkTool",     //网络配置
                    @"UserLogic",       //用户管理
                    @"TabbarVC",        //tabbar
                    @"LoginVC");        //登录页
    
    // 检查系统更新
    [AppManager checkUserUpdate];

    // 检查用户是否在审核状态
    [AppManager checkIOSReviewStatue];

    // 加载引导页
    [WWelcomPage configGuideViewWithIphoneImages:@[@"引导页面1",@"引导页面2"]
                                   iphonexImages:@[@"引导页面1-ipx",@"引导页面2-ipx"]
                               enablePageControl:NO];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [AppManager checkIOSReviewStatue];
}

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
