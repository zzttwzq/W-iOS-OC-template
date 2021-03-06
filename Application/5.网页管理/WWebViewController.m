//
//  WWebViewController.m
//  wzqproject
//
//  Created by 吴志强 on 2017/12/13.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WWebViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "UIScrollView+MJExtension.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"

@interface WWebViewController ()

@property (nonatomic,strong) UIView *indacator;
@property (nonatomic,strong) NSMutableSet *userScripts;
@property (nonatomic,strong) UISwipeGestureRecognizer *swipe;

@end

@implementation WWebViewController

#pragma mark - 控制器生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([self controlNavigationBarByParentVC]) {
        
        if (!_showNavBar) {
            
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }
    }
}

- (BOOL)controlNavigationBarByParentVC
{
    return YES;
}

-(void)viewWillDisappear:(BOOL)sanimated
{
    [super viewWillDisappear:YES];

    [self removAllowSecriptNameArray];

    __weak typeof(UIView *)weakSelf = _indacator;
    [UIView animateWithDuration:0.3 animations:^{

        weakSelf.alpha = 0;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.selfRefreshing = YES;

    self.userScripts = [NSMutableSet setWithObject:@"backUp"];

    self.urls = [NSMutableArray array];

    [self initWebView];

//    WEAK_SELF(WWebViewController);
//    _loadStatueView = [[WLoadStatueView alloc] initWithLogoImgName:nil];
//    _loadStatueView.refresh = ^(BOOL state) {
//
//        [weakSelf refreshWebView];
//    };
//    _loadStatueView.showInView = self.view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void) setShowLeftBtn:(BOOL)showLeftBtn
{
    _showLeftBtn = showLeftBtn;
    if (_showLeftBtn) {

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:0 target:self action:@selector(back)];
    }else{

        self.navigationItem.leftBarButtonItem = nil;
    }
}

/**
 显示返回取消的按钮(present出来的页面使用)
 */
- (void) showDismissBtns;
{
    self.showLeftBtn = YES;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置webview视图
+ (WKProcessPool *)singleWkProcessPool
{
    static dispatch_once_t onceToken;
    static WKProcessPool *sharedPool;
    dispatch_once(&onceToken, ^{
        sharedPool = [[WKProcessPool alloc] init];
    });
    return sharedPool;
}


/**
 初始化webview
 */
-(void)initWebView
{
    WKWebViewConfiguration *wkConfig = [[WKWebViewConfiguration alloc] init];
    
    //使用单例 解决locastorge 储存问题
    wkConfig.processPool = [WWebViewController singleWkProcessPool];
    //取消播放控制器
    if (@available(iOS 10.0, *)) {
        wkConfig.mediaTypesRequiringUserActionForPlayback = YES;
    } else {
            // Fallback on earlier versions
    }
    wkConfig.allowsInlineMediaPlayback = YES;

    //初始化并指定代理
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:wkConfig];
    if (_showNavBar) {

        self.webView.height = ScreenHeight - Height_NavBar - Height_Bottom + 20;
    }
    else{

        self.webView.height = ScreenHeight - Height_Bottom + 20;
    }
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];


    //添加手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(close2)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];


    //适配机型
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }


    //添加到控制器上
    [self.view addSubview:self.webView];
}

//- (void)setDisAbleSwipeBack:(BOOL)disAbleSwipeBack
//{
//    _disAbleSwipeBack = disAbleSwipeBack;
//
//    if (!_disAbleSwipeBack) {
//
//        //添加手势
//        _swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
//        _swipe.direction = UISwipeGestureRecognizerDirectionRight;
//        [self.view addGestureRecognizer:_swipe];
//    }
//    else{
//
//        [self.view removeGestureRecognizer:_swipe];
//    }
//}


#pragma mark - 设置方法
/**
 设置进度

 @param process 进度
 */
-(void)setProcess:(float)process
{
    if (!_disableIndicator) {

        if (!_indacator) {

            _indacator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
            _indacator.backgroundColor = [UIColor blackColor];
            [[UIApplication sharedApplication].keyWindow addSubview:_indacator];
        }
    }
    __weak typeof(UIView *)weakSelf = _indacator;
    [UIView animateWithDuration:0.5 animations:^{

        self.indacator.width = process*[[UIScreen mainScreen] bounds].size.width;
    } completion:^(BOOL finished) {

        if (process == 1.0) {

            [UIView animateWithDuration:0.3 animations:^{

                weakSelf.alpha = 0;
            }];
        }
    }];
}


- (void) setListenNetWorking:(BOOL)ListenNetWorking
{
    _ListenNetWorking = ListenNetWorking;
//    _loadStatueView.ListenNetWorking = _ListenNetWorking;
}


/**
 清除缓存

 @param clearCache 默认不清除
 */
-(void)setClearCache:(BOOL)clearCache
{
    _clearCache = clearCache;

    if (_clearCache) {

        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            NSSet *websiteDataTypes= [NSSet setWithArray:@[
                                                           WKWebsiteDataTypeDiskCache,
                                                           WKWebsiteDataTypeMemoryCache,
                                                           WKWebsiteDataTypeCookies,
                                                           ]];

            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{

            }];
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
        }
        else {
                //先删除cookie
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
                {
                [storage deleteCookie:cookie];
                }

            NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                    objectForKey:@"CFBundleIdentifier"];
            NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
            NSString *webKitFolderInCaches = [NSString
                                              stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
            NSString *webKitFolderInCachesfs = [NSString
                                                stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
            NSError *error;
            /* iOS8.0 WebView Cache的存放路径 */
            [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
            /* iOS7.0 WebView Cache的存放路径 */
            [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
            NSString *cookiesFolderPath = [libraryDir stringByAppendingString:@"/Cookies"];
            [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&error];
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
        }
    }
}


/**
 设置下拉刷新

 @param disAblePullRefresh 是否取消 默认是有的
 */
-(void)setDisAblePullRefresh:(BOOL)disAblePullRefresh
{
    _disAblePullRefresh = disAblePullRefresh;
    if (disAblePullRefresh) {

        self.webView.scrollView.mj_header = nil;
    }else{

//        self.webView.scrollView.mj_header = [WRefreshView initHeaderWithController:self action:@selector(refreshWebView)];
    }
}


/**
 设置取消页面加载进度条

 @param disableIndicator 是否取消，默认是有的
 */
-(void)setDisableIndicator:(BOOL)disableIndicator
{
    _disableIndicator = disableIndicator;

    if (!_disableIndicator) {

        _indacator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        _indacator.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_indacator];
    }else{

        [_indacator removeFromSuperview];
        _indacator = nil;
    }
}


-(void)close2
{
    if (!_disAbleSwipeBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)close
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 刷新webview
//刷新自己
-(void)refreshWebView;
{
    if ([self.webView.URL.absoluteString containsString:@"(null)"]) {

        self.selfRefreshing = YES;
        [self loadRequestURLString:self.urlString];
    }else{

        self.selfRefreshing = YES;
        [self loadRequestURLString:self.webView.URL.absoluteString];
    }
}


- (void) restoreWebviewUrl;
{
    
}


/**
 请求网络

 @param url 要加载的url字符串
 */
-(void)loadRequestURLString:(NSString *)url;
{
    //1.是否清除缓存
    if (self.clearCache) {
        self.clearCache = YES;
    }

//    //2.如果没有http 就添加http
//    if (![url containsString:@"http://"] &&
//        ![url containsString:@"https://"]) {
//
//        url = [NSString stringWithFormat:@"http://%@",url];
//    }
//
//    //3.添加utf8编码
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    url = [url stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
//    url = [url stringByReplacingOccurrencesOfString:@"%25" withString:@"%"];

    NSURL *urls = [NSURL URLWithString:url];

    NSURLRequest *request = [NSURLRequest requestWithURL:urls];

    //4.请求页面
    [self.webView loadRequest:request];
}

- (void) setShowNavBar:(BOOL)showNavBar
{
    _showNavBar = showNavBar;
    if (!_showNavBar) {

        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{

        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

#pragma mark - 监听脚本事件
/**
 添加监听脚本

 @param scriptNameArray 监听脚本数组
 */
- (void) addScriptHandlerWithScriptNameArray:(NSArray *)scriptNameArray;
{
    //JS调用OC 添加处理脚本
    for (int i = 0; i<scriptNameArray.count; i++) {

        [[self.webView configuration].userContentController addScriptMessageHandler:self name:scriptNameArray[i]];
        [self.userScripts addObject:scriptNameArray[i]];
    }
}


/**
 移除字段监听
 */
- (void) removAllowSecriptNameArray;
{
    for (NSString *key in self.userScripts) {

        [[self.webView configuration].userContentController removeScriptMessageHandlerForName:key];
    }
}


#pragma mark - WKNavigationDelegate来追踪加载过程
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
{
    [self setProcess:0.3];

//    _loadStatueView.type = WViewLoadingType_IsLoading;

    webView.scrollView.scrollEnabled = NO;
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
{
    [self.webView.scrollView.mj_header endRefreshing];

    [self setProcess:0.6];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
{
    [self.webView.scrollView.mj_header endRefreshing];

    [self setProcess:1.0];

    //添加标题
    if (self.title.length == 0) {
        self.title = self.webView.title;
    }

//    _loadStatueView.type = WViewLoadingType_LoadSuccess;
    webView.scrollView.scrollEnabled = YES;
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
{
    [self.webView.scrollView.mj_header endRefreshing];

//    _loadStatueView.type = WViewLoadingType_LoadError;
}

#pragma mark - WKNavigtionDelegate来进行页面跳转
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
{

}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
{
//    //获取请求的url路径.
//    NSString *requestString = navigationResponse.response.URL.absoluteString;
//    WKLog(@"requestString:%@",requestString);

//    // 遇到要做出改变的字符串
//    NSString *subStr = @"www.baidu.com";
//    if ([requestString rangeOfString:subStr].location != NSNotFound) {
//        WKLog(@"这个字符串中有subStr");
//            //回调的URL中如果含有百度，就直接返回，也就是关闭了webView界面
//        [self.navigationController  popViewControllerAnimated:YES];
//    }

    decisionHandler(WKNavigationResponsePolicyAllow);//崩在这里
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
{
//    NSString *urlString = navigationAction.request.URL.absoluteString;
//    [self.urls addObject:urlString];
//
//    _selfRefreshing = NO;
//    if (self.handelUrlChange) {
//
//        if ([urlString containsString:@"about:blank"]) {
//
//            decisionHandler(WKNavigationActionPolicyAllow);
//        }
//        else{
//
//            decisionHandler(WKNavigationActionPolicyCancel);
////            self.handelUrlChange(urlString, ^(int count){
////
////                decisionHandler(count);
////            });
//        }
//    }
//    else{
//
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate来进行页面跳转
//1.创建一个新的WebVeiw
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
{
    return nil;
}

//2.WebVeiw关闭（9.0中的新方法）
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);
{

}

//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
{
    WLOG(@"< wwebview >  %@",message);
    completionHandler();
}

//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler;
{

}

//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;
{

}

//6.处理脚本
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"backUp"]){

        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - scrocllview 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{

}

@end
