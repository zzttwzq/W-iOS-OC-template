//
//  TabbarVC.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/17.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "TabbarVC.h"
#import "QFHomeVC.h"
#import "QFMineVC.h"
#import "QFComunity.h"

@interface TabbarVC ()<UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *itemArr;
@property (nonatomic,strong) NSMutableArray *vcArray;
@property (nonatomic,assign) NSInteger defaultIndex;

@property (nonatomic,assign) BOOL cancelYaoQin;

@end

@implementation TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.

    //1.处理tabbar
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : Tabbar_Text_Normal_Color} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : Tabbar_Text_HighLighted_Color} forState:UIControlStateSelected];
    [UITabBar appearance].backgroundColor = Tabbar_BackGround_Color;

    //2.添加控制器
    [self addWithController:[QFHomeVC new] title:@"首页" image:@"首页" selectedImage:@"首页_selected"];

    [self addWithController:[QFComunity new] title:@"社区" image:@"社区" selectedImage:@"社区_selected"];

    [self addWithController:[QFMineVC new] title:@"我的" image:@"我的" selectedImage:@"我的_selected"];

    self.viewControllers = self.vcArray;

    //3.处理tabbar item
    self.itemArr = [NSMutableArray array];

    Class class = NSClassFromString(@"UITabBarButton");

    for (UIView *subView in self.tabBar.subviews) {

        if ([subView isKindOfClass:class]) {

            [self.itemArr addObject:subView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addWithController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    NavgationVC *nav = [[NavgationVC alloc] initWithRootViewController:controller];

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    controller.tabBarItem.image = myImage;

    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    controller.tabBarItem.selectedImage = mySelectedImage;
    controller.tabBarItem.title = title;

        //设置图片居中，这里的4.5，根据实际中间按钮图片大小来决定
        //    Vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
        //设置不显示文字，将title的位置设置成无限远，就看不到了
    controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);

    if (!self.vcArray) {
        self.vcArray = [NSMutableArray array];
    }
    [self.vcArray addObject:nav];
}


    //点击动画
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger idx = [tabBar.items indexOfObjectIdenticalTo:item];

    if (_defaultIndex == idx) return;

    _defaultIndex = idx;
    UIView *view = self.itemArr[idx];

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.fromValue = @1;
    animation.toValue = @1.2;
    animation.duration = 0.2;
    animation.autoreverses = YES; //返回动画时间与duration相同
    animation.removedOnCompletion = YES;

        //把动画添加上去就OK了
    [view.layer addAnimation:animation forKey:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.selectedViewController preferredStatusBarStyle];
}

- (void) toCategory
{
    self.selectedIndex = 1;
}

@end
