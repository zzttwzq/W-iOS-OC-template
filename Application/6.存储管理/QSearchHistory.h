//
//  QSearchHistory.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/10/7.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,QSearchType) {
    QSearchType_All,
    QSearchType_People,
    QSearchType_Shop,
    QSearchType_Service,  //服务
    QSearchType_Product,  //商城产品
};


@interface QSearchHistoryModel : WSqlRecorder

@property(nonatomic,assign)int s_id;
@property(nonatomic,copy)NSString *cl_Label;
@property(nonatomic,assign)int cl_Type;
@property(nonatomic,assign)NSInteger cl_UserId;
@property(nonatomic,assign)NSInteger cl_DateTimeSpan;

@end


@interface QSearchHistory : NSObject

/**
 配置用户搜索记录数据
 */
+ (void) configSearchTable;


/**
 添加数据

 @param type 类型
 @param label 要添加的数据
 */
+ (NSArray *) addDataWithType:(QSearchType)type
                        label:(NSString *)label;



/**
 删除所有

 @param type 类型
 */
+ (void) deleteDataWithType:(QSearchType)type;



/**
 获取列表数据

 @param type 类型
 @return 返回数据数组
 */
+ (NSMutableOrderedSet *) getListWithType:(QSearchType)type;

@end
