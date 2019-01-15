//
//  WToast.h
//  Pods-WMessage_Tests
//
//  Created by 吴志强 on 2018/7/16.
//

#import <Foundation/Foundation.h>

//toast位置
typedef NS_ENUM(NSInteger,WMESSAGE_POSITION) {
    WMESSAGE_POSITION_TYPE_TOP,
    WMESSAGE_POSITION_TYPE_MIDDLE,
    WMESSAGE_POSITION_TYPE_BOTTOM
};

//toast动画
typedef NS_ENUM(NSInteger,WMESSAGE_ANIMATION) {
    WMESSAGE_ANIMATION_TYPE_FADE,
    WMESSAGE_ANIMATION_TYPE_SLIPFROMTOP,
    WMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM
};

//主题颜色
typedef NS_ENUM(NSInteger,WMESSAGE_STYLE) {
    WMESSAGE_STYLE_BLACK,
    WMESSAGE_STYLE_WHITE
};


@interface WToast : NSObject
@property (nonatomic,assign) WMESSAGE_POSITION toastPosition;
@property (nonatomic,assign) WMESSAGE_ANIMATION toastAnimationStyle;
@property (nonatomic,assign) WMESSAGE_STYLE toastStyle;


/**
 获取全局单利

 @return 返回单利
 */
+ (WToast *) totastManager;


#pragma mark - 显示吐司消息
/**
 吐司消息

 @param toastMessage 要显示的吐司消息
 */
+(void)showToast:(NSString *)toastMessage;


/**
 toast消息

 @param message 消息
 @param position 位置
 @param animationType 动画类型
 @param style 是否有动画
 */
+(void)showMessage:(NSString *)message
fromBottomPosition:(WMESSAGE_POSITION)position
     animationType:(WMESSAGE_ANIMATION)animationType
             style:(WMESSAGE_STYLE)style;

@end
