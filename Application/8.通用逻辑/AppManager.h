//
//  AppManager.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/20.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject

+ (void) checkUserUpdate;


/**
 检查iOS 是否正在审核
 */
+ (void) checkIOSReviewStatue;

@end

NS_ASSUME_NONNULL_END
