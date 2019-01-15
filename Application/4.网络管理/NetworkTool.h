//
//  NetworkConfig.h
//  aaa
//
//  Created by 吴志强 on 2018/9/12.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WNetwork/WNetwork.h>

typedef void(^NetWorkCallBack)(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData);

@interface NetworkTool : NSObject
/**
 配置网络
 */
+ (void) configNetworking;

#pragma mark - 开始请求
/**
 获取get请求

 @param urlString 请求url
 @param params 参数
 @param response 请求回调
 */
+ (void) getRequestWithUrl:(NSString *)urlString
                    params:(id)params
                  response:(NetWorkCallBack)response;


/**
 获取post请求

 @param urlString 请求url
 @param params 参数
 @param response 请求回调
 */
+ (void) postRequestWithUrl:(NSString *)urlString
                     params:(id)params
                   response:(NetWorkCallBack)response;


+ (void) uploadImageWithURL:(NSString *)URL
                     params:(NSDictionary *)params
                      image:(UIImage *)image
                  imageName:(NSString *)imageName
                   imageKey:(NSString *)imageKey
               compressRate:(float)compressRate
           progressCallBack:(progressBlock)progressCallBack
                   response:(NetWorkCallBack)response;

@end
