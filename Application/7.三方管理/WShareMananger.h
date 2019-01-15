//
//  WShareMananger.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/19.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

NS_ASSUME_NONNULL_BEGIN

@interface WShareMananger : NSObject

+ (void) configShare;

/**
 分享图片

 @param shareImage 分享的图片
 @param thumbImage 缩略图 可以是网络地址url  也可是本地图片对象
 @param controller 当前控制器
 @param platformType 分享平台
 */
- (void)shareWithImage:(id _Nullable)shareImage
            thumbImage:(id _Nullable)thumbImage
            controller:(UIViewController *_Nullable)controller
          platformType:(UMSocialPlatformType)platformType;


/**
 分享文本内容

 @param text 文字
 @param controller 控制器
 @param platformType 平台
 */
- (void) shareWithText:(NSString *_Nullable)text
            Controller:(UIViewController *_Nullable)controller
          platformType:(UMSocialPlatformType)platformType;



@end

NS_ASSUME_NONNULL_END
