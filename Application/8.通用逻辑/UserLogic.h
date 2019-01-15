//
//  UserLogic.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BindUserInfoVC.h"

#import "TabbarVC.h"
#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPassVC.h"

#import "QUserStorage.h"

NS_ASSUME_NONNULL_BEGIN

#define CurrentUser [UserLogic globalInstance]
#define userLogined [UserLogic isUserLogined]
#define canShowAll [UserLogic isShowAll]
#define checkUserNeedLogined if ([UserLogic isNeedLogin]) {return;}

typedef NS_ENUM(NSInteger,UserLoginType) {
    UserLoginType_Password,  //密码登录
    UserLoginType_Sms,       //短信登录
    UserLoginType_Weixin,    //微信登录
    UserLoginType_QQ,        //qq登录
    UserLoginType_Weibo,     //微博登录
    UserLoginType_Custmer,   //游客登录
};

typedef NS_ENUM(NSInteger,UserCodeType) {
    UserCodeType_Registed,  //用户已经注册的情况下发送验证码
    UserCodeType_UNRegisted,//用户没有注册的情况下发送验证码
    UserCodeType_WeixBind,  //用户绑定微信
};

@interface UserLogic : NSObject

@property(nonatomic,assign)NSInteger id;   //用户id
@property(nonatomic,copy)NSString *token;  //token
@property(nonatomic,copy)NSString *name;   //用户名
@property(nonatomic,copy)NSString *avatar; //用户头像
@property(nonatomic,copy)NSString *my_invite_code; //我的邀请码
@property(nonatomic,copy)NSString *first_invite_code; //邀请我的用户的邀请码
@property(nonatomic,copy)NSString *mobile; //用户手机号
@property(nonatomic,assign)int fans;     //粉丝
@property(nonatomic,copy)NSString *available_balance; //可用金额
@property(nonatomic,assign)BOOL vip;       //是否是vip
@property(nonatomic,assign)double login_type; //登录类型
@property (nonatomic,assign) BOOL authorWithTaobao; //是否淘宝授权
@property (nonatomic,copy) NSString *total_income; //用户累计收益
@property (nonatomic,assign) BOOL weixin; //是否已经绑定微信

/**
 苹果是否已经过审核
 */
@property (nonatomic,assign) BOOL isIOSReady;

@property (nonatomic,assign) int groupid;

#pragma mark - 用户登录
/**
 创建用户单利

 @return 返回用户单利
 */
+ (UserLogic *)globalInstance;


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


/**
 第三方授权

 @param loginType 登录类型
 @param controller 控制器
 @param callBack 回调
 */
+ (void) thirdPartAuthorWithLoginType:(UserLoginType)loginType
                           controller:(UIViewController *)controller
                             callBack:(Dict_Block)callBack;


/**
 验证第三方登录是否已经绑定

 @param loginType 登录类型
 @param infoDict 授权信息
 @param controller 控制器
 @param callBack 回调
 */
+ (void) thirdPartLoginWithLoginType:(UserLoginType)loginType
                            infoDict:(NSDictionary *)infoDict
                          controller:(UIViewController *)controller
                            callBack:(StateBlock)callBack;


/**
 登出
 */
- (void) logout;


#pragma mark - 用户信息
/**
 获取用户信息

 @param callBack 回调
 */
- (void) getUserInfoWithCallBack:(Dict_Block)callBack;

/**
 更新用户数据

 @param params 更新的参数
 @param callBack 回调
 */
- (void) updateUserInfoWithParams:(NSDictionary *)params
                         callBack:(BlankBlock)callBack;

/**
 修改用户密码

 @param oldPass 旧密码
 @param newPass 新密码
 @param callBack 回调
 */
- (void) updateUserPassWordWithOldPass:(NSString *)oldPass
                               newPass:(NSString *)newPass
                              callBack:(BlankBlock)callBack;

/**
 忘记用户密码

 @param params 参数
 @param callBack 回调
 */
+ (void) forgetUserPassWordWithParams:(NSDictionary *)params
                             callBack:(BlankBlock)callBack;


/**
 获取用户好友列表

 @param page 页数
 @param arrayBack 回调
 */
- (void) getUserFriendListWithPage:(int)page
                         arrayBack:(Array_Block)arrayBack;


/**
 获取用户好友列表

 @param image 图片
 @param callBack 回调
 */
- (void) uploadUserHeaderImage:(UIImage *)image
                      callBack:(StringBlock)callBack;


/**
 用户反馈

 @param feedBack 反馈文字
 @param callBack 回调
 */
- (void) sendUserFeedBack:(NSString *)feedBack
                 callBack:(StateBlock)callBack;

#pragma mark - 判断用户状态
/**
 用户是否已经登录
 */
+ (BOOL) isUserLogined;


/**
 是否需要登录，如果需要就直接跳转到登录界面
 */
+ (BOOL) isNeedLogin;


/**
 显示所有内容

 @return 是否
 */
+ (BOOL) isShowAll;


#pragma mark - 本地化操作
/**
 保存到本地
 */
- (void) saveToLocal;


/**
 更新本地用户（如果没有会自动创建）
 */
- (void) updateLocal;


/**
 移除本地用户（不要直接使用，用logout）
 */
- (void) removeCurrentUserFromLocal;


/**
 获取本地数据到内存中
 */
+ (void) getGlobalUserFromLocal;


#pragma mark - 用户行为

/**
 去首页
 */
+ (void) gotoHomeView;


/**
 去登录页面
 */
+ (void) gotoLoginView;


/**
 去注册页面
 */
+ (void) gotoRegisterView;


/**
 修改密码
 */
+ (void) gotoChangePassword;


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

/**
 获取淘宝授权接口

 @param callBlock 验证码回调
 */
+ (void) getUserTaobaoAutheWithCallBlock:(StringBlock)callBlock;

@end

NS_ASSUME_NONNULL_END
