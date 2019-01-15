//
//  AppUrls.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#ifndef AppUrls_h
#define AppUrls_h

#ifdef DEBUG

    /******* 测试状态 ******/
    #define IS_TEST 1
    #define MAIN_HOST @"http://47.110.41.16:8768/qfx-api"
//    #define MAIN_HOST @"http://192.168.1.110:8768/qfx-api"
    #define IMAGE_HOST @"http://admin.shengduoduo.xin"

#else

    /******* 正式状态 ******/
    #define IS_TEST 0
    #define MAIN_HOST @"http://47.110.41.16:8768/qfx-api"
    #define IMAGE_HOST @"http://admin.shengduoduo.xin"

#endif

//用户协议
#define USER_AGREEMENT @"http://47.110.41.16/server.html";

//登录接口
#define loginURL [NSString stringWithFormat:@"%@/user/userInfo/login",MAIN_HOST]

//获取短信
#define sendSmsURL [NSString stringWithFormat:@"%@/user/sms/send",MAIN_HOST]

//注册接口
#define registerURL [NSString stringWithFormat:@"%@/user/userInfo/register",MAIN_HOST]

//判断手机号是否绑定
#define isWeixinBind [NSString stringWithFormat:@"%@/user/userWxbind/isWxbind",MAIN_HOST]

//第三方登录绑定接口
#define thirdBind [NSString stringWithFormat:@"%@/user/userInfo/author",MAIN_HOST]

//验证是否在审核中
#define isIosInReview [NSString stringWithFormat:@"%@/user/sms/open",MAIN_HOST]

//淘宝授权接口
#define getTaobaoAuthorUrl [NSString stringWithFormat:@"%@/user/userTaobaoBind/getTaobaoAuthorize",MAIN_HOST]

// 用户反馈
#define sendUserFeedBackURL [NSString stringWithFormat:@"%@/user/userInfo/feedback",MAIN_HOST]

// 图片上传地址
#define imageUploadURL [NSString stringWithFormat:@"%@/system/upload",MAIN_HOST]

// 忘记密码
#define forgetUserPass [NSString stringWithFormat:@"%@/user/userInfo/retrievePwd",MAIN_HOST]

// 修改密码
#define updateUserPass [NSString stringWithFormat:@"%@/user/userInfo/updatePwd",MAIN_HOST]

// 获取用户信息
#define getUserInfo [NSString stringWithFormat:@"%@/user/userInfo/findMyInfo",MAIN_HOST]

// 更新用户信息
#define updateUserInfo [NSString stringWithFormat:@"%@/user/userInfo/myUpdate",MAIN_HOST]

//获取好友列表
#define getUserFriendList [NSString stringWithFormat:@"%@/user/userInfo/queryMyLevelListPage",MAIN_HOST]

// 获取用户收益信息
#define getUserIncomeInfo [NSString stringWithFormat:@"%@/user/userIncomeSum/findMySum",MAIN_HOST]

// 获取用户收益详情列表
#define getIncomeDetialList [NSString stringWithFormat:@"%@/user/userIncomeRecord/queryListPage",MAIN_HOST]

//获取分类详情列表接口
#define categoryList [NSString stringWithFormat:@"%@/product/productGroup/query",MAIN_HOST]

//获取分类详情列表接口
#define categoryDetialList [NSString stringWithFormat:@"%@/product/groupProduct/queryListPage2",MAIN_HOST]

//获取分类详情头部banner图接口
#define categoryDetialBanner [NSString stringWithFormat:@"%@/product/productGroup/findById",MAIN_HOST]

//获取首页数据
#define getIndexHeaderData [NSString stringWithFormat:@"%@/product/productInfo/index",MAIN_HOST]

//获取首页推荐数据
#define getIndexRecommendList [NSString stringWithFormat:@"%@/product/groupProduct/queryListPage2",MAIN_HOST]

//获取订单列表
#define getOrderList [NSString stringWithFormat:@"%@/order/orderInfo/queryListPage",MAIN_HOST]

//搜索taobao商品列表
#define searchTaobaoProductList [NSString stringWithFormat:@"%@/product/productInfo/search",MAIN_HOST]

//搜索自有商品列表
#define searchOwnProductList [NSString stringWithFormat:@"%@/product/productInfo/queryListPage",MAIN_HOST]

//查询商品列表
#define getProductList [NSString stringWithFormat:@"%@/product/productInfo/queryListPage",MAIN_HOST]

//查询商品详情
#define getProductDetial [NSString stringWithFormat:@"%@/product/productInfo/findById",MAIN_HOST]

//收藏商品
#define becomeMyFavoriteProduct [NSString stringWithFormat:@"%@/product/productInfo/findById",MAIN_HOST]

//记录浏览足迹
#define recordProduct [NSString stringWithFormat:@"%@/product/productInfo/findById",MAIN_HOST]

//获取热搜商品
#define getHotSearchProductList [NSString stringWithFormat:@"%@/product/productSearchHot/queryListPage",MAIN_HOST]

//获取商品淘口令
#define getProductTKL [NSString stringWithFormat:@"%@/product/productInfo/tpwdCreate",MAIN_HOST]

//获取限时时间列表
#define getLimitTimeArray [NSString stringWithFormat:@"%@/product/limitTime/queryListPage",MAIN_HOST]

//获取限时商品列表
#define getLimitTimeProductArray [NSString stringWithFormat:@"%@/product/productLimitTime/queryListPage",MAIN_HOST]

#endif /* AppUrls_h */
