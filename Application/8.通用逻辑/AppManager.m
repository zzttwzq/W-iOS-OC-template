//
//  AppManager.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/20.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (void) checkUserUpdate;
{
//    [NetworkTool getRequestWithUrl:isIosInReview
//                            params:nil
//                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {
//
//                              NSString *string = [NSString stringWithFormat:@"%@",totalData[@"data"]];
//                              if ([string isEqualToString:@"<null>"] ||
//                                  [string isEqualToString:@"<nil>"] ||
//                                  [string isEqualToString:@"(null)"]) {
//
//                                  CurrentUser.isIOSReady = YES;
//                              }
//                              else{
//
//                                  CurrentUser.isIOSReady = NO;
//                              }
//                          }];

//    SHOW_INFO_MESSAGE(@"您已经是最新版！");
}

/**
 检查iOS 是否正在审核
 */
+ (void) checkIOSReviewStatue;
{
//    [NetworkTool getRequestWithUrl:isIosInReview
//                            params:nil
//                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {
//
//                              NSString *string = [NSString stringWithFormat:@"%@",totalData[@"data"]];
//                              if ([string isEqualToString:@"<null>"] ||
//                                  [string isEqualToString:@"<nil>"] ||
//                                  [string isEqualToString:@"(null)"]) {
//
//                                  CurrentUser.isIOSReady = YES;
//                              }
//                              else{
//
//                                  CurrentUser.isIOSReady = NO;
//                              }
//                          }];

    CurrentUser.isIOSReady = YES;
}

@end
