//
//  UIViewController+viewcontrollerEnhanced.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/18.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "UIViewController+viewcontrollerEnhanced.h"

@implementation UIViewController (viewcontrollerEnhanced)

- (void) showDismissBtn;
{
    UIView *view = VIEW_WITH_RECT(0, 0, 40, 20);
    view.userInteractionEnabled = YES;
//    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];

    UIImageView *image = IMAGE_WITH_RECT(5, 0, 10, 20);
    image.image = IMAGE_NAMED(@"back");
    [view addSubview:image];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

@end
