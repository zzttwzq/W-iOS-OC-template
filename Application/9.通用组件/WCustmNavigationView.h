//
//  WCustmNavigationView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/27.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCustmNavigationView : UIView

@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,copy) BlankBlock backClick;

@property (nonatomic,assign) BOOL showBackBtn;

- (instancetype) initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
