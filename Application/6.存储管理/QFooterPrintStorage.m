//
//  QFooterPrintStorage.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/10/7.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import "QFooterPrintStorage.h"

#define QFOOTER_PRRINT_TABLE_NAME @"QFOOTER_PRRINT_TABLE_NAME"

@implementation QFooterPrintModel


@end


@implementation QFooterPrintStorage

/**
 配置足迹数据表
 */
+ (void) configFooterPrintTable;
{
    NSDictionary *dic = @{
                          @"s_id":@"INTEGER PRIMARY KEY AUTOINCREMENT",
                          @"userid":@"INTEGER",
                          @"num_iid":@"varchar(500) UNIQUE",
                          @"title":@"varchar(500)",
                          @"image":@"varchar(100)",
                          @"after_price":@"DOUBLE",
                          @"zk_final_price":@"DOUBLE",
                          @"datetime":@"INTEGER",
                          @"oneself":@"DOUBLE",
                          @"coupon_start_time":@"VARCHAR",
                          @"coupon_end_time":@"VARCHAR",
                          @"coupon_click_url":@"VARCHAR",
                          @"couponAmount":@"VARCHAR",
                          };

    WSqlTable *table = [WSqlTable createTableWithName:QFOOTER_PRRINT_TABLE_NAME infoDic:dic];

    //超过15天自动删除表中的数据。
    NSString *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FOOTER_PRINT_LAST_DELETE_DATE"];
    if (!lastDate) {

        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",[NSDate nowTimeStamp]] forKey:@"FOOTER_PRINT_LAST_DELETE_DATE"];
    }
    else{

        NSInteger date = [NSDate nowTimeStamp]-[lastDate integerValue];
        if (date > 15*24*3600) {

            [table clearTable];
        }
    }
}


+ (QFooterPrintModel *)getModelWithID:(NSString *)idstring
                                 page:(int)page;
{
    NSString *condition = [NSString stringWithFormat:@"userid = %ld and num_iid = %@",CurrentUser.id,idstring];

    WSqlTable *table = [WSqlTable tableWithName:QFOOTER_PRRINT_TABLE_NAME];
    NSArray *array = [table listWithRecordeName:@"QFooterPrintModel"
                                           Page:page
                                          limit:20
                                          where:condition
                                        orderBy:@"datetime desc"];

    if (array.count > 0) {
        return array[0];
    }

    return nil;
}

/**
 添加或修改数据

 @param model 模型
 */
+ (void) addProductWithModel:(QFooterPrintModel *)model;
{
    QFooterPrintModel *existModel = [self getModelWithID:[NSString stringWithFormat:@"%@",model.num_iid] page:0];
    [existModel setTableName:QFOOTER_PRRINT_TABLE_NAME];

    if (existModel) {

        existModel.datetime = model.datetime;
        [existModel update];
    }
    else{

        [model setTableName:QFOOTER_PRRINT_TABLE_NAME];
        [model insert];
    }
}


/**
 获取列表数据

 @param page 分页数
 @return 返回数组
 */
+ (NSArray *) getListWithPage:(int)page;
{
    NSString *condition = [NSString stringWithFormat:@"userid = %ld",CurrentUser.id];

    WSqlTable *table = [WSqlTable tableWithName:QFOOTER_PRRINT_TABLE_NAME];
    NSArray *array = [table listWithRecordeName:@"QFooterPrintModel"
                                           Page:page
                                          limit:20
                                          where:condition
                                        orderBy:@"datetime desc"];
    return array;
}


/**
 删除所有数据
 */
+ (void) deleteAll;
{
    [[WSqlTable tableWithName:QFOOTER_PRRINT_TABLE_NAME] clearTable];
}

@end
