//
//  LocalStorageConfig.m
//  aaa
//
//  Created by 吴志强 on 2018/9/12.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "LocalStorage.h"
#import <WSqlJelly/WSqlSession.h>

#import "QUserStorage.h"
#import "QSearchHistory.h"
#import "QFooterPrintStorage.h"

@implementation LocalStorage
/**
 配置本地数据库
 */
+ (void) configLocalStorage;
{
    [[WSqlSession session] selectDataBaseWithDBName:@"qdd.db"];

    //配置足迹数据表
    [QUserStorage initQuser];

    //配置足迹数据表
    [QFooterPrintStorage configFooterPrintTable];

    //配置用户搜索历史记录数据表
    [QSearchHistory configSearchTable];

    //获取用户上次保存的信息
    [UserLogic getGlobalUserFromLocal];

    if (!userLogined) {

        [QUserStorage deleteAll];
    }
}


@end
