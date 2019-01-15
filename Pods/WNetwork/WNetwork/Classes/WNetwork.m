//
//  WNetwork.m
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import "WNetwork.h"

@implementation WNetwork

static WNetwork *networkInstence;
static dispatch_once_t networkOnce;

/**
 创建用户数据单利

 @return 返回单利数据
 */
+ (WNetwork *)shareInstence;
{
    dispatch_once(&networkOnce, ^{

        networkInstence = [[WNetwork alloc] init];
    });

    return networkInstence;
}


/**
 苹果自带的方法实现的请求

 @param method 请求方法
 @param urlString 请求url
 @param params 参数
 @param headers 请求头字典
 @param successCallBack 成功回调返回结果
 @param errorCallBack 返回结果
 */
+ (void) taskWithMethod:(WNetWorkMethod)method
              urlString:(NSString *_Nullable)urlString
                 params:(id)params
                headers:(NSDictionary *_Nullable)headers
        successCallBack:(Dict_Block)successCallBack
          errorCallBack:(Error_Block)errorCallBack;
{
    //1.url地址编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];

    //2.调用代理，如果发现返回no 就停止继续请求
    if ([WNetwork shareInstence].willStartRequest) {
        BOOL flag = [WNetwork shareInstence].willStartRequest(urlString,params);
        if (!flag) {
            return ;
        }
    }

    //3.使用设置来创建一个sessons
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];


    //4.创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (method == WNetWorkMethod_GET) {

        request.HTTPMethod = @"GET";

        NSDictionary *postDic = params;
        urlString = [urlString stringByAppendingString:@"?"];

            //设置get数据
        for (NSString *key in postDic) {

            urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,postDic[key]]];
        }
        urlString = [urlString substringToIndex:urlString.length-1];
    }
    else{

        request.HTTPMethod = @"POST";

        //设置post数据
        if ([params isKindOfClass:[NSString class]]) {

            request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
        }
        else if ([params isKindOfClass:[NSDictionary class]]) {

            NSDictionary *postDic = params;

            if (postDic) {

                NSString *string = @"";
                for (NSString *key in postDic) {

                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,postDic[key]]];
                }
                string = [string substringToIndex:string.length-1];
                string = [string stringByAppendingString:@"&type=JSON"];

                request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
            }
        }
    }


    //5.设置类型
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [request setValue:@"application/json;text/html;" forHTTPHeaderField:@"Content-Type"];


    //6.由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                            if (error) {

                                                [self handleError:error callBack:errorCallBack];
                                            }
                                            else {

                                                if (data) {

                                                    NSError *decodeError;

                                                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&decodeError];

                                                    if (decodeError) {

                                                        [self handleError:decodeError callBack:errorCallBack];
                                                    }
                                                    else{

                                                        [self handleSuccess:dict callBack:successCallBack];
                                                    }
                                                }
                                                else{

                                                    NSError *noDataError = [NSError errorWithDomain:@"服务器返回空数据。" code:100000 userInfo:nil];
                                                    [self handleError:noDataError callBack:errorCallBack];
                                                }
                                            }
                                        }];


    //7.启动任务
    [task resume];
}


/**
 苹果自带的方法实现get的请求

 @param urlString 请求url
 @param params 参数
 @param headers 请求头字典
 @param successCallBack 成功回调返回结果
 @param errorCallBack 返回结果
 */
+ (void) getTaskWithUrl:(NSString *_Nullable)urlString
                 params:(id)params
                headers:(NSDictionary *_Nullable)headers
        successCallBack:(Dict_Block)successCallBack
          errorCallBack:(Error_Block)errorCallBack;
{
    [self taskWithMethod:WNetWorkMethod_GET urlString:urlString params:params headers:headers successCallBack:successCallBack errorCallBack:errorCallBack];
}


/**
 苹果自带的方法实现post的请求

 @param urlString 请求url
 @param params 参数
 @param headers 请求头字典
 @param successCallBack 成功回调返回结果
 @param errorCallBack 返回结果
 */
+ (void) postTaskWithUrl:(NSString *_Nullable)urlString
                  params:(id)params
                 headers:(NSDictionary *_Nullable)headers
         successCallBack:(Dict_Block)successCallBack
           errorCallBack:(Error_Block)errorCallBack;
{
    [self taskWithMethod:WNetWorkMethod_POST urlString:urlString params:params headers:headers successCallBack:successCallBack errorCallBack:errorCallBack];
}


#pragma mark - AFNetworking实现的方法
static AFHTTPSessionManager *manager = nil;

/**
 创建一个单利

 @param headers 请求头字典
 @return 返回单利
 */
+ (AFHTTPSessionManager *_Nullable) sharedManagerWithHeaders:(NSDictionary *)headers;
{
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    manager.requestSerializer.timeoutInterval = 10.0f; // 超时时间

    //1.设置请求类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/xml",@"text/plain", nil];

    //2.最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 10;

    //3.设置请求头
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    return manager;
}


/**
 afn封装的get方法

 @param urlString 请求地址
 @param postDic 发送的数据
 @param headers 请求头字典
 @param progress 下载进度
 @param successCallBack 成功回调
 @param errorCallBack 失败回调
 */
+(void)getRequestWithURL:(NSString *_Nullable)urlString
                 postDic:(NSDictionary *_Nullable)postDic
                 headers:(NSDictionary *_Nullable)headers
                progress:(progressBlock _Nullable)progress
         successCallBack:(Dict_Block)successCallBack
           errorCallBack:(Error_Block)errorCallBack;
{
    [[WNetwork sharedManagerWithHeaders:headers]
     GET:urlString
     parameters:postDic
     progress:^(NSProgress * _Nonnull downloadProgress) {

        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (responseObject != nil) {

            [self handleSuccess:responseObject callBack:successCallBack];
        }
        else{

            NSError *error = [NSError errorWithDomain:@"返回的数据为空！！！" code:0 userInfo:nil];
            [self handleError:error callBack:errorCallBack];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self handleError:error callBack:errorCallBack];
    }];
}


/**
 afn封装的post方法

 @param urlString 请求地址
 @param postDic 发送的数据
 @param headers 请求头字典
 @param progress 下载进度
 @param successCallBack 成功回调
 @param errorCallBack 失败回调
 */
+(void)postRequestWithURL:(NSString *_Nullable)urlString
                  postDic:(NSDictionary *_Nullable)postDic
                  headers:(NSDictionary *_Nullable)headers
                 progress:(progressBlock _Nullable)progress
          successCallBack:(Dict_Block)successCallBack
            errorCallBack:(Error_Block)errorCallBack;
{
    [[WNetwork sharedManagerWithHeaders:headers]
     POST:[urlString mutableCopy]
     parameters:[postDic mutableCopy]
     progress:^(NSProgress * _Nonnull uploadProgress) {

        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (responseObject != nil) {

            [self handleSuccess:responseObject callBack:successCallBack];
        }
        else {

            NSError *error = [NSError errorWithDomain:@"返回的数据为空！！！" code:0 userInfo:nil];
            [self handleError:error callBack:errorCallBack];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self handleError:error callBack:errorCallBack];
    }];
}


#pragma mark - 工具方法
/**
 获取时间戳

 @return 返回时间戳字符串
 */
+ (NSString * _Nullable)getTimeStamp;
{
    //获取系统的时间日期
    NSDate *senddate = [NSDate date];
    return [NSString stringWithFormat:@"%f",[senddate timeIntervalSince1970]];
}


/**
 iOS字典 转 json

 @param dict 要转换的字典
 @return 转换成json的字符串
 */
+(NSString * _Nullable)dictToJSON:(NSDictionary * _Nullable)dict;
{
    if (!dict) {
        return nil;
    }

    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


/**
 data 转 json 字典

 @param data 要转换的字典
 @return 转换成json的字符串
 */
+ (NSDictionary * _Nullable) DictWithData:(NSData * _Nullable)data;
{
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }

    return dic;
}



/**
 json字符串转字典

 @param string json字符串
 @return 转换成模型
 */
+(NSDictionary * _Nullable)jsonStringToDic:(NSString * _Nullable)string;
{
    if (string == nil ||
        ![string isKindOfClass:[NSString class]]) {

        return nil;
    }

    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }

    return dic;
}


#pragma mark - 其他方法
/**
 成功过滤器

 @param dict 成功的数据
 @param callBack 成功回调
 */
+ (void) handleSuccess:(NSDictionary *)dict
              callBack:(Dict_Block)callBack;
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        callBack(dict);
    });
}


/**
 失败过滤器

 @param error 失败类
 @param callBack 失败回调
 */
+ (void) handleError:(NSError *)error
            callBack:(Error_Block)callBack;
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        callBack(error);
    });
}

@end
