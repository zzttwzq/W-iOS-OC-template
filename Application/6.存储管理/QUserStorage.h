//
//  QUserStorage.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/9/29.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QUserModel : WSqlRecorder
/*
 手机
 */
@property (nonatomic,assign) NSInteger s_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic,copy) NSString *first_leader;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic ,  copy)NSString *token;

@property (nonatomic , assign)NSInteger expire;    /*unix时间戳，token有效时间为30天*/

@property (nonatomic , copy)NSString *userid;

@property (nonatomic,assign) BOOL isTestUser;

@end;


@interface QUserStorage : NSObject
/**
 初始化用户表
 */
+ (void) initQuser;


/**
 添加用户

 @param recoder 要添加的记录
 */
+ (void) addUser:(QUserModel *)recoder;


/**
 更新用户

 @param recoder 更新的模型
 */
+ (void) updateUser:(QUserModel *)recoder;


/**
 删除用户

 @param userid 用户ID
 */
+ (void) deleteUser:(NSInteger)userid;


/**
 获取本地用户记录数据

 @param userid userid
 @return 返回模型
 */
+ (QUserModel *) getUserModel:(NSInteger)userid;


/**
 获取本地用户记录数据

 @return 返回模型
 */
+ (QUserModel *) getUserModel;


/**
 删除所有数据
 */
+ (void) deleteAll;

@end;
