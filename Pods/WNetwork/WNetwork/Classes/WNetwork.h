//
//  WNetwork.h
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@protocol WNetWorkDelegate <NSObject>

/**
 将要开始请求网络

 @param url 请求url
 @param params 请求参数
 @return 返回是否可以继续请求
 */
- (BOOL) willStartRequest:(NSString *)url params:(NSDictionary *)params;

@end

typedef NS_ENUM(NSInteger,WNetWorkMethod) {
    WNetWorkMethod_GET,
    WNetWorkMethod_POST,
};

typedef void(^NSMutableURLRequest_Block)(NSMutableURLRequest *request);
typedef void(^AFNetRequest_Block)(AFHTTPRequestSerializer *request);
typedef void(^Dict_Block)(NSDictionary *dict);
typedef void(^Error_Block)(NSError *error);
typedef void(^progressBlock)(NSProgress * _Nonnull progress);
typedef BOOL(^String_Dict_Block)(NSString *url,NSDictionary *params);

@interface WNetwork : NSObject

@property (nonatomic,copy) String_Dict_Block willStartRequest;

/**
 创建用户数据单利

 @return 返回单利数据
 */
+ (WNetwork *)shareInstence;


#pragma mark - 苹果自带的方法实现的请求
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


#pragma mark - AFNetworking实现的方法
/**
 创建一个单利

 @param headers 请求头字典
 @return 返回单利
 */
+ (AFHTTPSessionManager *_Nullable) sharedManagerWithHeaders:(NSDictionary *)headers;


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


#pragma mark - 工具方法
/**
 获取时间戳

 @return 返回时间戳字符串
 */
+ (NSString * _Nullable)getTimeStamp;


/**
 字典转json

 @param dic 要转换的字典
 @return 转换成json的字符串
 */
+(NSString * _Nullable)dictToJSON:(NSDictionary * _Nullable)dic;


/**
 data 转 json 字典

 @param data 要转换的字典
 @return 转换成json的字符串
 */
+ (NSDictionary * _Nullable) DictWithData:(NSData * _Nullable)data;


/**
 json字符串转字典

 @param string json字符串
 @return 转换成模型
 */
+(NSDictionary * _Nullable)JSONStringToDic:(NSString * _Nullable)string;

@end
