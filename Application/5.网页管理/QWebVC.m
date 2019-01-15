//
//  QWebVCViewController.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/9/27.
//  Copyright © 2018年 Wuzhiqiang. All rights reserved.
//

#import "QWebVC.h"
#import <WRouter/WRouterURLDecoder.h>

@interface QWebVC ()

@end

@implementation QWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadRequestURLString:self.urlString];

    [self addScriptHandlerWithScriptNameArray:@[@"gotoTaobao"]];

    self.webView.top = Height_NavBar;
}

- (void) setview
{
    self.view.top = Height_NavBar;
    self.webView.top = Height_NavBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//6.处理脚本
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSDictionary *dict = [WNetwork JSONStringToDic:message.body];

    if ([message.name isEqualToString:@"gotoTaobao"] ||
        [dict[@"function"] isEqualToString:@"gotoTaobao"]) {

        if (dict[@"data"]) {

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao://uland.taobao.com/coupon/edetail?%@", dict[@"data"]]];

            // 如果已经安装淘宝客户端，就使用客户端打开链接
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
{
    NSString *urlString = navigationAction.request.URL.absoluteString;

    WRouterURLDecoder *decoder = [[WRouterURLDecoder alloc] initWithScheme:urlString];
    if ([decoder.host containsString:@"47.110.41.16:8768"]) {

//        NSString *code = decoder.params[@"code"];
//
//        NSString *url = [NSString stringWithFormat:@"%@/index/getconf?command=bind_taobao_user_id&id=%ld&token=%@&code=%@",MAIN_HOST,QUserManager.id,QUserManager.token,code];
//
//        [NetworkTool getRequestWithUrl:url
//                                 params:nil
//                               response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {
//
//                                   if (status) {
//
//                                       SHOW_SUCCESS_MESSAGE(totalData[@"msg"]);
//                                   }
//                                   else{
//
//                                       SHOW_ERROR_MESSAGE(totalData[@"msg"]);
//                                   }
//                               }];

        [self performSelector:@selector(action) withObject:nil afterDelay:1];

//        [self performSelector:@selector(action) afterDelay:1];


    }

    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void) action
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
