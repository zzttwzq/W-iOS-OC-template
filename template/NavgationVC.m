//
//  NavgationVC.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "NavgationVC.h"

@interface NavgationVC ()<UIGestureRecognizerDelegate>

@end

@implementation NavgationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

+ (void)initialize
{
    [self setupNavigationBarTheme];
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];

    if (Navigation_BackGround_Color) {
        [appearance setBarTintColor:Navigation_BackGround_Color];
    }

    if (Navigation_BackGround_Image.length > 0) {
        appearance.barTintColor = [UIColor redColor];
    }

    // 2.设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = Navigation_Title_Color;
    textAttrs[NSFontAttributeName] = Navigation_Title_Font;

    CGSize shadowOffset = CGSizeZero;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = shadowOffset;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0){

        UIView *view = VIEW_WITH_RECT(0, 0, 40, 20);
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];

        UIImageView *image = IMAGE_WITH_RECT(5, 0, 10, 20);
        image.image = IMAGE_NAMED(Navigation_Back_Image_Name);
        [view addSubview:image];

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count > 1;
}

@end
