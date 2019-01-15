//
//  WToast.m
//  Pods-WMessage_Tests
//
//  Created by 吴志强 on 2018/7/16.
//

#import "WToast.h"

@implementation WToast
/**
 获取全局单利

 @return 返回单利
 */
+ (WToast *) totastManager;
{
    static WToast *sharedInstance = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}


/**
 吐司消息

 @param toastMessage 要显示的吐司消息
 */
+(void)showToast:(NSString *)toastMessage;
{
    [self showMessage:toastMessage fromBottomPosition:WMESSAGE_POSITION_TYPE_BOTTOM animationType:WMESSAGE_ANIMATION_TYPE_FADE style:WMESSAGE_STYLE_BLACK];
}


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
{
    if (![message isKindOfClass:[NSString class]]
        && message.length > 0) {
        return;
    }

    UIWindow * window = [UIApplication sharedApplication].keyWindow;

    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGSize LabelSize = [message boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.height-80) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

    //显示的位置------------//------------//------------//------------//------------//------------//------------//
    float labWidth = LabelSize.width+20;
    float labHeight = LabelSize.height+20;

    float left = window.center.x - labWidth/2;

    float labX = left > 10 ? left : 10;
    float labY = 0;

    if (position == WMESSAGE_POSITION_TYPE_TOP) {

        labY = 30 + labHeight/2;
//        animationType = WMESSAGE_ANIMATION_TYPE_SLIPFROMTOP;
    }
    else if (position == WMESSAGE_POSITION_TYPE_MIDDLE) {

        labY = window.center.y - labHeight/2;
//        animationType = WMESSAGE_ANIMATION_TYPE_FADE;
    }
    else if (position == WMESSAGE_POSITION_TYPE_BOTTOM) {

        labY = window.frame.size.height - labHeight - 80;
//        animationType = WMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM;
    }
    else{

        labY = position;
//        if (position <= window.center.x) {
//
//            animationType = WMESSAGE_ANIMATION_TYPE_SLIPFROMTOP;
//        }else{
//
//            animationType = WMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM;
//        }
    }

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labX, 0, labWidth, labHeight)];

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:message];
    NSMutableParagraphStyle *styles = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    styles.firstLineHeadIndent = 6;
    styles.tailIndent = -10; //设置与尾部的距离
    styles.headIndent = styles.firstLineHeadIndent;
    styles.alignment = NSTextAlignmentLeft;
    [attrString addAttribute:NSParagraphStyleAttributeName value:styles  range:NSMakeRange(0, message.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,message.length)];//设置字体
    label.attributedText = attrString;

    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:70/255.00f green:70/255.00f blue:70/255.00f alpha:0.8];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;//自动换行
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    [window addSubview:label];

    //整体颜色------------//------------//------------//------------//------------//------------//------------//
    if (style == WMESSAGE_STYLE_WHITE) {
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
    }


    //显示动画------------//------------//------------//------------//------------//------------//------------//
    if (animationType == WMESSAGE_ANIMATION_TYPE_FADE) {

        label.frame = CGRectMake(labX, labY, labWidth, labHeight);
        label.alpha = 0;

        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1;
        }];

    }
    else if (animationType == WMESSAGE_ANIMATION_TYPE_SLIPFROMTOP) {

        label.frame = CGRectMake(labX, 0, labWidth, labHeight);

        [UIView animateWithDuration:0.3 animations:^{

            label.frame = CGRectMake(labX, labY, labWidth, labHeight);
        }];

    }
    else if (animationType == WMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM) {

        label.frame = CGRectMake(labX, window.frame.size.height, labWidth, labHeight);

        [UIView animateWithDuration:0.3 animations:^{

            label.frame = CGRectMake(labX, labY, labWidth, labHeight);
        }];
    }

    __block int timeout = 2.5; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置

                [UIView animateWithDuration:0.3 animations:^{

                    label.alpha = 0;
                } completion:^(BOOL finished) {

                    [label removeFromSuperview];
                }];
            });
        }else{

            dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置


            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
