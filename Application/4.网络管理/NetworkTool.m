//
//  NetworkConfig.m
//  aaa
//
//  Created by 吴志强 on 2018/9/12.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
/**
 配置网络
 */
+ (void) configNetworking;
{
    //配置请求之前的路由
    [WNetwork shareInstence].willStartRequest = ^BOOL(NSString *url, NSDictionary *params) {

        WLOG(@"当前请求:>>>>%@----%@",url,params);
        return YES;
    };
}

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
{
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    [headers setValue:CurrentUser.token forKey:@"Token"];

    [WNetwork getRequestWithURL:urlString
                        postDic:params
                        headers:headers
                       progress:nil successCallBack:^(NSDictionary *dict) {

        [self successFillter:dict callBack:response];

    } errorCallBack:^(NSError *error) {

        [self errorFillter:error callBack:response];
    }];
}


/**
 获取post请求

 @param urlString 请求url
 @param params 参数
 @param response 请求回调
 */
+ (void) postRequestWithUrl:(NSString *)urlString
                     params:(id)params
                   response:(NetWorkCallBack)response;
{
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    [headers setValue:CurrentUser.token forKey:@"Token"];

    [WNetwork postRequestWithURL:urlString
                         postDic:params
                         headers:headers
                        progress:nil
                 successCallBack:^(NSDictionary *dict) {

        [self successFillter:dict callBack:response];

    } errorCallBack:^(NSError *error) {

        [self errorFillter:error callBack:response];
    }];
}


+ (void) uploadImageWithURL:(NSString *)URL
                     params:(NSDictionary *)params
                      image:(UIImage *)image
                  imageName:(NSString *)imageName
                   imageKey:(NSString *)imageKey
               compressRate:(float)compressRate
           progressCallBack:(progressBlock)progressCallBack
                   response:(NetWorkCallBack)response;
{
    AFHTTPSessionManager *manager = [WNetwork sharedManagerWithHeaders:nil];

    [manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        NSData *data = UIImageJPEGRepresentation(image, compressRate);

            //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:imageKey
                                fileName:imageName
                                mimeType:@"image/png"];

    } progress:progressCallBack success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {

            dict = responseObject;
        }
        else{

            dict = [WNetwork DictWithData:responseObject];
        }

        [self successFillter:dict callBack:response];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self errorFillter:error callBack:response];
    }];
}


#pragma mark - 请求过滤
/**
 过滤请求成功

 @param dict 成功字典
 @param callBack 回调
 */
+ (void) successFillter:(NSDictionary *)dict callBack:(NetWorkCallBack)callBack
{
    BOOL success = NO;

    if (!dict) {

        DEBUG_LOG(self, @"返回空的数据！");
    }
    else if ([dict[@"code"] integerValue] == 30003) {

        LOGOUT;
        return;
    }
    else if ([dict[@"code"] integerValue] == 0) {

        success = YES;
    }
    else{

        SHOW_ERROR_MESSAGE(dict[@"message"]);
    }

    id data = dict[@"data"];
    if ([data isKindOfClass:[NSNull class]]) {
        data = nil;
    }

    if (callBack) {
        callBack(success,[dict[@"code"] integerValue],dict[@"message"],data,dict);
    }
}


/**
 过滤请求失败

 @param error 请求失败
 */

/**
 请求出现错误，一般是没有网络，网络不稳定或接口报错

 @param error 错误类
 @param callBack 回调
 */
+ (void) errorFillter:(NSError *)error callBack:(NetWorkCallBack)callBack
{
    if (error) {

        if ([error.localizedDescription containsString:@"似乎已断开与互联网的连接"] ||
            error.code == -1009) {

//            [UIAlertController showAlertWithTarget:nil
//                                             title:nil
//                                           message:@"当前网络不可用!"
//                                           actions:@[@"取消",@"去设置"]
//                                            colors:nil
//                                     comfirmAction:^(UIAlertAction *action) {
//
//                                         if ([action.title isEqualToString:@"去设置"]) {
//
//                                             NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                                             if ([ [UIApplication sharedApplication] canOpenURL:url]){
//                                                 [[UIApplication sharedApplication] openURL:url];
//                                             }
//                                         }
//                                     }];
        }
        else{

            DEBUG_LOG(self, error.description);
        }

        if (callBack) {
            callBack(NO,0,nil,nil,nil);
        }
    }
}


#pragma mark - 设置请求
/**
 设置普通请求头

 @param requet 普通请求头
 */
+ (void)setHeader:(NSMutableURLRequest *)requet;
{
//    NSString *timeSnap = [NSDate getTimeWithFormart:@(WSystemDateTimeFormat_TimeSnap) convertTimeZoneToChina:YES];
//    NSString *signValue = [NSString stringWithFormat:@"%@MLB0987@!,hmPassword",timeSnap];
//    signValue = [signValue md5];
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[HMGlobalData getToken] forKey:@"Token"];
//    [dict setObject:[HMGlobalData getUserName] forKey:@"userName"];
//    [dict setObject:signValue forKey:@"DecryptValue"];
//    [dict setObject:timeSnap forKey:@"Sign"];
//
//    for (NSString * key in [dict allKeys]) {
//
//        [requet setValue:dict[key] forHTTPHeaderField:key];
//    }

        //    NSLog(@"%@",requet.allHTTPHeaderFields);
}


@end
