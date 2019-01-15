//
//  QFooterPrintStorage.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/10/7.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFooterPrintModel : WSqlRecorder

@property(nonatomic,assign)NSInteger userid;
@property(nonatomic,assign)NSInteger s_id;
@property(nonatomic,assign)NSInteger datetime;
@property(nonatomic,copy)NSString *num_iid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,assign)double zk_final_price;
@property(nonatomic,assign)double after_price;

@property(nonatomic,assign)double oneself;
@property(nonatomic,copy)NSString *coupon_start_time;
@property(nonatomic,copy)NSString *coupon_end_time;
@property(nonatomic,copy)NSString *coupon_click_url;
@property(nonatomic,copy)NSString *couponAmount;

@end

@interface QFooterPrintStorage : NSObject

/**
 配置足迹数据表
 */
+ (void) configFooterPrintTable;


+ (QFooterPrintModel *)getModelWithID:(NSString *)idstring
                                 page:(int)page;

/**
 添加或修改数据

 @param model 模型
 */
+ (void) addProductWithModel:(QFooterPrintModel *)model;


/**
 获取列表数据

 @param page 分页数
 @return 返回数组
 */
+ (NSArray *) getListWithPage:(int)page;


/**
 删除所有数据
 */
+ (void) deleteAll;
@end
