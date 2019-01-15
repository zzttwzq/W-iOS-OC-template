//
//  routerConfig.m
//  aaa
//
//  Created by 吴志强 on 2018/9/12.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "RouterConfig.h"
#import "WRouter.h"

@implementation RouterConfig

/**
 全局配置路由
 */
+(void)configGlobalRouters;
{
    WRouter *router = [WRouter globalRouter];
    [router addHostTitles:@[@"hmapp",@"hengmeiapp",@"hengmeiApp",@"hmApp"]];
    [router addHosts:@[@"testapi.eh-y.com",@"api.eh-y.com"]];

    [router addRouterFromePlistFile:@"RouterConfig.plist"];


//    [router addGlobalRouterWithUrlScheme:@"location" handler:^(id viewController, IDDataBlock dataCallBack) {
//
//        HLocationVC *view = viewController;
//        view.selectCallBack = ^(BOOL state) {
//
//            if (dataCallBack) {
//                dataCallBack(@{@"state":@(1)});
//            }
//        };
//    }];
}

@end
