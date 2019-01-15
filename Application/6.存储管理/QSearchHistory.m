//
//  QSearchHistory.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/10/7.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import "QSearchHistory.h"

#define QSearchDataTable @"QSearchDataTable"
#define QSearchEmptyUser @"0"

@implementation QSearchHistoryModel

@end

@implementation QSearchHistory
/**
 配置用户搜索记录数据
 */
+ (void) configSearchTable;
{
    NSDictionary *dic = @{
                          @"s_id":@"INTEGER PRIMARY KEY AUTOINCREMENT",
                          @"cl_UserId":@"INTEGER",
                          @"cl_Type":@"int(10)",
                          @"cl_Label":@"varchar(200)",
                          @"cl_DateTimeSpan":@"INTEGER",
                          };

    [WSqlTable createTableWithName:QSearchDataTable infoDic:dic];
}


/**
 添加数据

 @param type 类型
 @param label 要添加的数据
 */
+ (NSArray *) addDataWithType:(QSearchType)type
                        label:(NSString *)label;
{
        //1.获取列表数据（时间倒序）
    NSString *string = [NSString stringWithFormat:@"%ld",CurrentUser.id];
    if (string.length == 0) {
        string = QSearchEmptyUser;
    }

    NSMutableArray *array = [NSMutableArray arrayWithArray:[[WSqlTable tableWithName:QSearchDataTable] listWithRecordeName:@"HSearchHistoryModel" Page:0 limit:15 where:[NSString stringWithFormat:@"cl_UserId = %@ and cl_Type = %ld",string,type] orderBy:@"cl_DateTimeSpan DESC"]];

        //2.判断个数，如果超过10个自动覆盖
    if (label.length > 0) {

        QSearchHistoryModel *model = [[QSearchHistoryModel alloc] initWithTableName:QSearchDataTable];
        model.cl_UserId = CurrentUser.id;
        model.cl_Type = type;
        model.cl_Label = label;
        model.cl_DateTimeSpan = [NSDate nowTimeStamp];
        [model insert];

        [array insertObject:model atIndex:0];

        if (array.count >= 10) {

            QSearchHistoryModel *model = array[0];
            [model remove];
        }

        for (int i = (int)array.count-1; i>=0; i--) {

            QSearchHistoryModel *model = array[i];
            if ([model.cl_Label isEqualToString:label]) {

                [model remove];
                [array removeObject:model];

                break;
            }
        }
    }

    return array;
}


/**
 删除所有

 @param type 类型
 */
+ (void) deleteDataWithType:(QSearchType)type;
{
    NSString *string = [NSString stringWithFormat:@"%ld",CurrentUser.id];
    if (string.length == 0) {
        string = QSearchEmptyUser;
    }

    NSArray *array =[[WSqlTable tableWithName:QSearchDataTable] listWithRecordeName:@"QSearchHistoryModel" Page:0 limit:15 where:[NSString stringWithFormat:@"cl_UserId = %@ and cl_Type = %ld",string,type] orderBy:@"cl_DateTimeSpan DESC"];

    for (int i = 0; i<array.count; i++) {

        QSearchHistoryModel *model = array[i];
        [model remove];
    }
}


/**
 获取列表数据

 @param type 类型
 @return 返回数据数组
 */
+ (NSMutableOrderedSet *) getListWithType:(QSearchType)type;
{
    NSString *string = [NSString stringWithFormat:@"%ld",CurrentUser.id];
    if (string.length == 0) {
        string = QSearchEmptyUser;
    }

    NSArray *array =[[WSqlTable tableWithName:QSearchDataTable] listWithRecordeName:@"QSearchHistoryModel" Page:0 limit:15 where:[NSString stringWithFormat:@"cl_UserId = %@ and cl_Type = %ld",string,type] orderBy:@"cl_DateTimeSpan DESC"];

    NSMutableOrderedSet *listArray = [NSMutableOrderedSet new];
    for (int i = 0; i<array.count; i++) {

        QSearchHistoryModel *model = array[i];
        [listArray addObject:model.cl_Label];
    }

    return listArray;
}

@end
