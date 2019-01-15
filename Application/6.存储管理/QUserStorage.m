//
//  QUserStorage.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/9/29.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import "QUserStorage.h"

#define QUSER_TABLE_NAME @"user"

@implementation QUserStorage

+ (void) initQuser;
{
    NSDictionary *dic = @{
                          @"s_id":@"INTEGER PRIMARY KEY AUTOINCREMENT",
                          @"nickname":@"varchar(100)",
                          @"phone":@"varchar(20)",
                          @"expire":@"INTEGER",
                          @"token":@"varchar(100)",
                          @"head_img":@"varchar(100)",
                          @"userid":@"varchar(100) unique",
                          @"first_leader":@"varchar(20)",
                          @"isTestUser":@"boolean",
                          };

    [WSqlTable createTableWithName:QUSER_TABLE_NAME infoDic:dic];

    //超过15天自动删除表中的数据。
//    NSString *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"userlastdate"];
//    if (!lastDate) {
//
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",[NSDate nowTimeStamp]] forKey:@"userlastdate"];
//    }
//    else{
//
//        NSInteger date = [NSDate nowTimeStamp]-[lastDate integerValue];
//        if (date > 15*24*3600) {
//
//            [table clearTable];
//        }
//    }
}

/**
 添加用户

 @param recoder 要添加的记录
 */
+ (void) addUser:(QUserModel *)recoder;
{
    [recoder setTableName:QUSER_TABLE_NAME];
    [recoder insert];
}


/**
 更新用户

 @param recoder 更新的模型
 */
+ (void) updateUser:(QUserModel *)recoder;
{
    [recoder setTableName:QUSER_TABLE_NAME];
    [recoder update];
}


/**
 删除用户

 @param userid 用户ID
 */
+ (void) deleteUser:(NSInteger)userid;
{
    QUserModel *model = [self getUserModel:userid];

    QUserModel *recorder = [[QUserModel alloc] initWithTableName:QUSER_TABLE_NAME];
    recorder.s_id = model.s_id;
    [recorder remove];
}


/**
 获取本地用户记录数据

 @param userid userid
 @return 返回模型
 */
+ (QUserModel *) getUserModel:(NSInteger)userid;
{
    NSArray *array = [[WSqlTable tableWithName:QUSER_TABLE_NAME] listWithRecordeName:@"QUserModel" where:[NSString stringWithFormat:@"userid = %ld",userid] orderBy:nil];

    if (array.count) {
        return array[0];
    }

    return nil;
}

/**
 获取本地用户记录数据

 @return 返回模型
 */
+ (QUserModel *) getUserModel;
{
    NSArray *array = [[WSqlTable tableWithName:QUSER_TABLE_NAME] listWithRecordeName:@"QUserModel" where:nil orderBy:nil];

    if (array.count) {
        return array[0];
    }

    return nil;
}

/**
 删除所有数据
 */
+ (void) deleteAll;
{
    [[WSqlTable tableWithName:QUSER_TABLE_NAME] clearTable];
}

@end


@implementation QUserModel


@end
