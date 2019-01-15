//
//  UserLogic.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "UserLogic.h"

@implementation UserLogic
static UserLogic *sharedInstance;
static dispatch_once_t UserOnce;

#pragma mark - 用户登录
/**
 创建用户单利

 @return 返回用户单利
 */
+ (UserLogic *)globalInstance;
{
    dispatch_once(&UserOnce, ^{

        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}


/**
 用户登录

 @param loginType 登录方式
 @param params 参数
 @param controller 控制器
 @param complete 完成回调
 */
+ (void) loginWithLoginType:(UserLoginType)loginType
                     params:(NSDictionary *)params
                 controller:(UIViewController *)controller
                   complete:(StateBlock)complete;
{
    //游客登录
    if (loginType == UserLoginType_Custmer) {

        if (complete) {
            complete(NO);
        }
    }
    //短信，密码登录
    else if (loginType == UserLoginType_Sms ||
        loginType == UserLoginType_Password) {

        NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];

        //登录的类型，1表示账号密码登录,2手机号码登录
        if (loginType == UserLoginType_Sms) {

            [paramDict setObject:@"2" forKey:@"login_type"];
        }
        else if (loginType == UserLoginType_Password) {

            [paramDict setObject:@"1" forKey:@"login_type"];
        }

        [NetworkTool getRequestWithUrl:loginURL
                                params:paramDict
                              response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                                  if (success) {

                                      [CurrentUser safeSetWithDict:data];
                                      [CurrentUser safeSetWithDict:data[@"user"]];

                                      [CurrentUser saveToLocal];

                                      if (complete) {
                                          complete(YES);
                                      }

                                      [UserLogic gotoHomeView];
                                  }
                                  else{

                                      if (complete) {
                                          complete(NO);
                                      }
                                  }
                              }];
    }
    //其他第三方登录
    else{

        //1.去授权
        [UserLogic thirdPartAuthorWithLoginType:loginType
                                controller:controller
                                  callBack:^(NSDictionary *dict) {

                                      //2.授权成功，去验证是否需要绑定账号
                                      if (dict) {

                                          [UserLogic thirdPartLoginWithLoginType:loginType
                                                                        infoDict:dict
                                                                      controller:controller
                                                                        callBack:complete];
                                      }
                                      else{

                                          if (complete) {
                                              complete(NO);
                                          }
                                      }
                                  }];
    }
}


/**
 第三方授权

 @param loginType 登录类型
 @param controller 控制器
 @param callBack 回调
 */
+ (void) thirdPartAuthorWithLoginType:(UserLoginType)loginType
                           controller:(UIViewController *)controller
                             callBack:(Dict_Block)callBack;
{
    if (loginType == UserLoginType_Weibo) {

    }
    else if (loginType == UserLoginType_Weixin) {

        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession
                                            currentViewController:controller
                                                       completion:^(id result, NSError *error) {

                                                           if (error) {

                                                               WLOG(@">>> 获取微信信息失败！%@",error.description);

                                                               SHOW_ERROR_MESSAGE(@"微信授权失败！");

                                                               if (callBack) {
                                                                   callBack(nil);
                                                               }
                                                           }
                                                           else {

                                                               UMSocialUserInfoResponse *resp = result;
                                                                   // 授权信息
                                                                   //            NSLog(@"Wechat uid: %@", resp.uid);
                                                                   //            NSLog(@"Wechat openid: %@", resp.openid);
                                                                   //            NSLog(@"Wechat unionid: %@", resp.unionId);
                                                                   //            NSLog(@"Wechat accessToken: %@", resp.accessToken);
                                                                   //            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                                                                   //            NSLog(@"Wechat expiration: %@", resp.expiration);
                                                                   // 用户信息
                                                                   //            NSLog(@"Wechat name: %@", resp.name);
                                                                   //            NSLog(@"Wechat iconurl: %@", resp.iconurl);
                                                                   //            NSLog(@"Wechat gender: %@", resp.unionGender);

                                                                   //                  第三方平台SDK源数据
                                                                   //                             NSLog(@"Wechat originalResponse: %@", resp.originalResponse);


                                                               if (callBack) {
                                                                   callBack(@{@"opend_id":resp.openid,
                                                                              @"name":resp.name,
                                                                              @"avatar":resp.iconurl});
                                                               }
                                                           }
                                                       }];
    }
    else if (loginType == UserLoginType_QQ) {

    }
}


/**
 第三方登录是否已经绑定

 @param loginType 登录类型
 @param infoDict 授权信息
 @param controller 控制器
 @param callBack 回调
 */
+ (void) thirdPartLoginWithLoginType:(UserLoginType)loginType
                            infoDict:(NSDictionary *)infoDict
                          controller:(UIViewController *)controller
                            callBack:(StateBlock)callBack;
{
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:infoDict];
    if (loginType == UserLoginType_Weibo) {

    }
    else if (loginType == UserLoginType_Weixin) {

    }
    else if (loginType == UserLoginType_QQ) {

    }

    SHOW_LOADING;

    [NetworkTool getRequestWithUrl:thirdBind
                            params:dic
                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                              DISMISS_LOADING;

                              if (success){

                                  [CurrentUser safeSetWithDict:data];

                                  if (callBack) {
                                      callBack(YES);
                                  }
                              }
                              else{

                                  BindUserInfoVC *view = [BindUserInfoVC new];
                                  view.infoDict = dic;
                                  [view showDismissBtn];
                                  NavgationVC *nav = [[NavgationVC alloc] initWithRootViewController:view];

                                  [controller presentViewController:nav animated:YES completion:nil];
                              }
                          }];
}


/**
 登出
 */
- (void) logout;
{
    [UserLogic gotoLoginView];

    [self removeCurrentUserFromLocal];
}

#pragma mark - 用户信息
/**
 获取用户信息

 @param callBack 回调
 */
- (void) getUserInfoWithCallBack:(Dict_Block)callBack;
{
    checkUserNeedLogined

    [NetworkTool getRequestWithUrl:getUserInfo
                            params:@{@"token":CurrentUser.token}
                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                              if (success) {
                                  if (callBack) {
                                      callBack(data);
                                  }
                              }
                              else{
                                  if (callBack) {
                                      callBack(nil);
                                  }
                              }
                          }];
}


/**
 更新用户数据

 @param params 更新的参数
 @param callBack 回调
 */
- (void) updateUserInfoWithParams:(NSDictionary *)params
                         callBack:(BlankBlock)callBack;
{
    checkUserNeedLogined

    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [paramsDic setObject:CurrentUser.token forKey:@"token"];

    [NetworkTool postRequestWithUrl:updateUserInfo
                             params:paramsDic
                           response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                               if (success) {

                                   if (callBack) {
                                       callBack();
                                   }
                               }
                           }];
}


/**
 修改用户密码

 @param oldPass 旧密码
 @param newPass 新密码
 @param callBack 回调
 */
- (void) updateUserPassWordWithOldPass:(NSString *)oldPass
                               newPass:(NSString *)newPass
                              callBack:(BlankBlock)callBack;
{
    checkUserNeedLogined

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:newPass forKey:@"newpassword"];
    [paramsDic setObject:oldPass forKey:@"password"];
    [paramsDic setObject:CurrentUser.token forKey:@"token"];

    [NetworkTool getRequestWithUrl:updateUserPass
                             params:paramsDic
                           response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                               if (success) {

                                   if (callBack) {
                                       callBack();
                                   }
                               }
                           }];
}


/**
 忘记用户密码

 @param params 参数
 @param callBack 回调
 */
+ (void) forgetUserPassWordWithParams:(NSDictionary *)params
                              callBack:(BlankBlock)callBack;
{
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    [NetworkTool getRequestWithUrl:forgetUserPass
                             params:paramsDic
                           response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                               if (success) {

                                   if (callBack) {
                                       callBack();
                                   }
                               }
                           }];
}


/**
 获取用户好友列表

 @param page 页数
 @param arrayBack 回调
 */
- (void) getUserFriendListWithPage:(int)page
                         arrayBack:(Array_Block)arrayBack;
{
    checkUserNeedLogined

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:@(page) forKey:@"page"];
    [paramsDic setValue:@(20) forKey:@"page_size"];
    [paramsDic setValue:CurrentUser.token forKey:@"token"];

    [NetworkTool getRequestWithUrl:getUserFriendList
                            params:paramsDic
                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                              if (success) {

                                  if (arrayBack) {
                                      arrayBack(data);
                                  }
                              }
                              else{

                                  if (arrayBack) {
                                      arrayBack(nil);
                                  }
                              }
                          }];
}


/**
 获取用户好友列表

 @param image 图片
 @param callBack 回调
 */
- (void) uploadUserHeaderImage:(UIImage *)image
                         callBack:(StringBlock)callBack;
{
    checkUserNeedLogined

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:@(CurrentUser.id) forKey:@"id"];
    [paramsDic setValue:CurrentUser.token forKey:@"token"];
    [paramsDic setValue:@"user" forKey:@"type"];

    [NetworkTool uploadImageWithURL:imageUploadURL
                             params:paramsDic
                              image:image
                          imageName:@"header.png"
                           imageKey:@"files"
                       compressRate:0.1
                   progressCallBack:^(NSProgress * _Nonnull progress) {

                       SHOW_PROGRESS(progress.fractionCompleted)

                   } response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                       if (success) {

                           NSArray *array = data[@"url"];

                           if (array.count > 0) {

                               if (callBack) {
                                   callBack(array[0]);
                               }
                           }
                           else{

                               SHOW_ERROR_MESSAGE(@"上传失败！");

                               if (callBack) {
                                   callBack(nil);
                               }
                           }
                       }
                       else{

                           SHOW_ERROR_MESSAGE(@"上传失败！");

                           if (callBack) {
                               callBack(nil);
                           }
                       }
                   }];
}


/**
 用户反馈

 @param feedBack 反馈文字
 @param callBack 回调
 */
- (void) sendUserFeedBack:(NSString *)feedBack
                 callBack:(StateBlock)callBack;
{
    checkUserNeedLogined

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:CurrentUser.token forKey:@"token"];
    [paramsDic setValue:@"user" forKey:@"type"];

//    [NetworkTool getRequestWithUrl:sendUserFeedBackURL
//                            params:paramsDic
//                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {
//
//
//                          }];

    callBack(YES);
}


#pragma mark - 判断用户状态
/**
 用户是否已经登录
 */
+ (BOOL) isUserLogined;
{
    if (CurrentUser.token.length > 0) {

        return YES;
    }

    return NO;
}


/**
 是否需要登录，如果需要就直接跳转到登录界面
 */
+ (BOOL) isNeedLogin
{
    if (![UserLogic isUserLogined]) {

        LOGOUT;

        return YES;
    }

    return NO;
}

/**
 显示所有内容

 @return 是否
 */
+ (BOOL) isShowAll;
{
    if (!CurrentUser.isIOSReady ||
        [CurrentUser.mobile isEqualToString:TEST_USER_ACCOUNT]) {

        return NO;
    }

    return YES;
}

#pragma mark - 本地化操作
/**
 保存到本地
 */
- (void) saveToLocal;
{
    if (CurrentUser.name.length > 0) {

        //1.先查询是否有
        QUserModel *model = [QUserStorage getUserModel:CurrentUser.id];

        //2.如果有就更新 ，没有就添加
        if (!model) {

            QUserModel *recoder = [QUserModel new];
            recoder.nickname = CurrentUser.name;
            recoder.first_leader = CurrentUser.first_invite_code;
            recoder.phone = CurrentUser.mobile;
            recoder.head_img = CurrentUser.avatar;
            recoder.token = CurrentUser.token;
            recoder.userid = [NSString stringWithFormat:@"%ld",CurrentUser.id];
            recoder.isTestUser = 0;

            [QUserStorage addUser:recoder];
        }
        else{

            QUserModel *recoder = [QUserModel new];
            recoder.s_id = model.s_id;
            recoder.nickname = CurrentUser.name;
            recoder.first_leader = CurrentUser.first_invite_code;
            recoder.phone = CurrentUser.mobile;
            recoder.head_img = CurrentUser.avatar;
            recoder.token = CurrentUser.token;
            recoder.userid = [NSString stringWithFormat:@"%ld",CurrentUser.id];
            recoder.isTestUser = 0;

            [QUserStorage updateUser:recoder];
        }
    }
    else{

        DEBUG_LOG(self, @"需要保存的用户信息不能为空！");
    }
}


/**
 更新本地用户（如果没有会自动创建）
 */
- (void) updateLocal;
{
    QUserModel *model = [QUserStorage getUserModel];
    if (model) {

        QUserModel *model2 = [QUserModel new];
        model2.s_id = model.s_id;
        model2.nickname = CurrentUser.name;
        model2.first_leader = CurrentUser.first_invite_code;
        model2.phone = CurrentUser.mobile;
        model2.head_img = CurrentUser.avatar;
        model2.token = CurrentUser.token;
        model2.isTestUser = 0;

        [QUserStorage updateUser:model2];
    }
}


/**
 移除本地用户（不要直接使用，用logout）
 */
- (void) removeCurrentUserFromLocal;
{
    if (CurrentUser.name.length > 0) {

        CurrentUser.name = @"";
        CurrentUser.token = @"";
        CurrentUser.avatar = @"";
        CurrentUser.id = 0;

        [QUserStorage deleteUser:CurrentUser.id];
    }
    else{
        DEBUG_LOG(self, @"用户已经退出登录！");
    }
}


/**
 获取本地数据到内存中
 */
+ (void) getGlobalUserFromLocal;
{
    QUserModel *model = [QUserStorage getUserModel];
    if (model) {

        CurrentUser.name = model.nickname;
        CurrentUser.first_invite_code = model.first_leader;
        CurrentUser.mobile = model.phone;
        CurrentUser.avatar = model.head_img;
        CurrentUser.token = model.token;
        CurrentUser.id = [model.userid integerValue];
    }
}


#pragma mark - 用户行为
/**
 去首页
 */
+ (void) gotoHomeView;
{
    keyViewController = [TabbarVC new];
}


/**
 去登录页面
 */
+ (void) gotoLoginView;
{
    keyViewController = [LoginVC new];
}


/**
 去注册页面
 */
+ (void) gotoRegisterView;
{
    keyViewController = [RegisterVC new];
}


/**
 修改密码
 */
+ (void) gotoChangePassword;
{
    keyViewController = [ForgetPassVC new];
}


#pragma mark - 其他
/**
 发送短信

 @param phonenum 要发送的手机号码
 @param phoneType 类型
 @param sender 按钮
 */
+ (void) sendSms:(NSString *)phonenum
       phoneType:(UserCodeType)phoneType
          sender:(UIButton *)sender;
{
    if (phonenum.length != 11) {

        SHOW_ERROR_MESSAGE(@"请输入正确的手机号！");
        return;
    }

    SHOW_LOADING;

    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc] init];
    [parmsDic setObject:phonenum forKey:@"mobile"];

    // 1手机号存在才发送 2手机号不存在发送
    if (phoneType == UserCodeType_Registed) {
        [parmsDic setObject:@"1" forKey:@"type"];
    }
    else if (phoneType == UserCodeType_UNRegisted) {
        [parmsDic setObject:@"2" forKey:@"type"];
    }
    else if (phoneType == UserCodeType_WeixBind) {
        [parmsDic setObject:@"0" forKey:@"type"];
    }

    [NetworkTool getRequestWithUrl:sendSmsURL
                             params:parmsDic
                           response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                               if (success) {

                                   DISMISS_LOADING;

                                   __block int timeouts = 60;
                                   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                                   dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                                   dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                                   dispatch_source_set_event_handler(_timer, ^{
                                       if(timeouts<=0){ //倒计时结束，关闭
                                           dispatch_source_cancel(_timer);
                                           dispatch_async(dispatch_get_main_queue(), ^{

                                               [sender setTitleColor:Main_Color forState:UIControlStateNormal];
                                               [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                                               sender.userInteractionEnabled = YES;
                                           });
                                       }
                                       else{

                                           int seconds = timeouts % 61;
                                           NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                                           dispatch_async(dispatch_get_main_queue(), ^{

                                               [sender setTitleColor:Text_Deital_Color forState:UIControlStateNormal];
                                               [sender setTitle:[NSString stringWithFormat:@"%@秒后发送",strTime] forState:UIControlStateNormal];
                                               sender.userInteractionEnabled = NO;

                                           });
                                           timeouts--;
                                       }
                                   });
                                   dispatch_resume(_timer);
                               }
                           }];
}


/**
 获取淘宝授权接口

 @param callBlock 验证码回调
 */
+ (void) getUserTaobaoAutheWithCallBlock:(StringBlock)callBlock;
{
    checkUserNeedLogined

    SHOW_LOADING

    [NetworkTool getRequestWithUrl:getTaobaoAuthorUrl
                            params:@{@"token":CurrentUser.token}
                          response:^(BOOL success, NSInteger status, NSString *msg, id data, NSDictionary *totalData) {

                              DISMISS_LOADING;

                              if (success) {

                                  if (callBlock) {
                                      callBlock(data);
                                  }
                              }
                          }];
}

@end
