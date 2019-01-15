//
//  WWebViewController.h
//  wzqproject
//
//  Created by 吴志强 on 2017/12/13.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
//#import "WLoadStatueView.h"
//#import "Definitions.h"
//#import "WTool.h"
//#import "WRefreshView.h"


//typedef void(^handelUrlChange)(NSString *newUrlString,CountBlock decisionHandler);

@interface WWebViewController : UIViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) NSMutableArray *urls;


/**
 url字符串
 */
@property (nonatomic,copy) NSString *urlString;   //url


/**
 取消进度指示条
 */
@property (nonatomic,assign) BOOL disableIndicator;//取消顶部导航条


/**
 是否显示导航条
 */
@property (nonatomic,assign) BOOL showNavBar;   //取消隐藏导航栏

/**
 导航条字体颜色
 */
@property (nonatomic,assign) BOOL statuBarWhiteColor;//白色的状态条


/**
 清除缓存
 */
@property (nonatomic,assign) BOOL clearCache;


/**
 处理url跳转
 */
//@property (nonatomic,copy) handelUrlChange  handelUrlChange;


/**
 是否可以下拉刷新
 */
@property (nonatomic,assign) BOOL disAblePullRefresh;

@property (nonatomic,assign) BOOL disAbleSwipeBack;


/**
 显示等待界面
 */
//@property (nonatomic,strong) WLoadStatueView *loadStatueView;


/**
 监听网络
 */
@property (nonatomic,assign) BOOL ListenNetWorking;


/**
 是否是自己刷新（直接刷新url）
 */
@property (nonatomic,assign) BOOL selfRefreshing;


/**
 显示自定义的返回按钮(可以重写set方法)
 */
@property (nonatomic,assign) BOOL showLeftBtn;


/**
 显示返回取消的按钮(present出来的页面使用)
 */
- (void)showDismissBtns;


/**
 初始化webview
 */
-(void)initWebView;

/**
 请求网络

 @param url 要加载的url字符串
 */
-(void)loadRequestURLString:(NSString *)url;

/**
 移除字段监听
 */
- (void) removAllowSecriptNameArray;

/**
 添加监听脚本

 @param scriptNameArray 监听脚本数组
 */
-(void)addScriptHandlerWithScriptNameArray:(NSArray *)scriptNameArray;


//刷新自己
- (void) refreshWebView;

- (void) restoreWebviewUrl;
@end
