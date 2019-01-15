//
//  BindUserInfoVC.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindUserInfoVC : UIViewController

@property (nonatomic,copy) NSDictionary *infoDict;
@property (nonatomic,assign) BOOL isRegisted;

+ (void) bindWeixinWithDict:(NSDictionary *)dict
                   callBack:(StateBlock)callBack;

@end

NS_ASSUME_NONNULL_END
