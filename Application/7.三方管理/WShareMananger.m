//
//  WShareMananger.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/19.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WShareMananger.h"

@implementation WShareMananger

+ (void) configShare;
{
    //5. U-Share 平台设置
    [UMConfigure setLogEnabled:YES];

    [UMConfigure initWithAppkey:UMeng_Appkey channel:nil];

    // ===================== 设置分享平台 =====================
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Weixin_Appkey appSecret:Weixin_AppSecret redirectURL:Weixin_RedirectURL];

    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_Appkey  appSecret:QQ_AppSecret redirectURL:QQ_RedirectURL];
}

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
{
    if (shareImage) {

        //  创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //  创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];

        //  设置缩略图
        shareObject.thumbImage = thumbImage;

        //  ⚠️注意：分享图片方式如下： 1. 分享图片仅适用本地图片加载，如UIImage或NSData数据传输。 2. 如需使用网络图片，确保URL为HTTPS图片链接，以便于U-Share SDK下载并进行分享，否则会分享失败。
        [shareObject setShareImage:shareImage];

        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;

        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:(platformType) messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {}];
    }
}


/**
 分享文本内容

 @param text 文字
 @param controller 控制器
 @param platformType 平台
 */
- (void) shareWithText:(NSString *_Nullable)text
            Controller:(UIViewController *_Nullable)controller
          platformType:(UMSocialPlatformType)platformType;
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = text;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:(platformType) messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {}];
}

- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
        //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";

        //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:@"https://www.umeng.com/img/index/demo/1104.4b2f7dfe614bea70eea4c6071c72d7f5.jpg"];

        //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

        //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
        //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
        //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";

        //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

        //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType
{
        //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
        //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
        //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
        //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

        //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
        //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

        //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
        //设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
        //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";

        //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

        //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

//- (void) 
@end
