//
//  QFMineVC.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/25.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "QFMineVC.h"

@interface QFMineVC ()

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *userImage;
@property (nonatomic,strong) UILabel *username;
@property (nonatomic,strong) UILabel *inviteCode;
@property (nonatomic,strong) UILabel *money1;
@property (nonatomic,strong) UILabel *money2;
@property (nonatomic,strong) UILabel *allMoney;

@property (nonatomic,strong) UIView *thirdBackView;

@property (nonatomic,assign) float totalHeight;

@end

@implementation QFMineVC

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = orange_Color;

    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50)];
    _scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroll];

    UIView *view1 = [self createHeader];
    [_scroll addSubview:view1];

    UIView *view2 = [self createYu_eWithOffset:view1.height];
    [_scroll addSubview:view2];

    self.totalHeight = view1.height+view2.height+65;

    if (!canShowAll) {
        self.totalHeight = view1.height+view2.height;
    }

    _scroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];

    [self getData];
}

- (UIView *) createHeader
{
    UIView *backView = VIEW_WITH_RECT(0, 0, ScreenWidth, 160);
    backView.backgroundColor = white_Color;
    backView.layer.cornerRadius = 5;
//    [backView shadowWithColor:RGBA(0, 0, 0, 0.2) offset:CGSizeMake(5, 5) radius:5];

    _userImage = IMAGE_WITH_RECT(20, 40, 70, 70);
    _userImage.layer.cornerRadius = 35;
    _userImage.userInteractionEnabled = YES;
    [_userImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modiuser)]];
    _userImage.layer.cornerRadius = 35;
    _userImage.layer.masksToBounds = YES;
    [backView addSubview:_userImage];

    UIButton *setting = BUTTON_WITH_RECT(ScreenWidth-60, _userImage.top-20, 60, 60);
    [setting setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [setting addTarget:self action:@selector(modiuser) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:setting];

    _username = LABEL_WITH_RECT(_userImage.right+10, _userImage.top+10, ScreenWidth-100, 20);
    _username.textColor = Text_Color;
    _username.font = Large_Font;
    _username.userInteractionEnabled = YES;
    [_username addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modiuser)]];
    [backView addSubview:_username];

    if (canShowAll) {

        _inviteCode = LABEL_WITH_RECT(_userImage.right+10, _username.bottom+10, 130, 20);
        _inviteCode.textColor = Text_Color;
        _inviteCode.font = Large_Font;
        [backView addSubview:_inviteCode];

        UIButton *copybutton = BUTTON_WITH_RECT(_inviteCode.right+15, _username.bottom+7.5, 40, 25);
        copybutton.userInteractionEnabled = YES;
        [copybutton setTitle:@"复制" forState:UIControlStateNormal];
        copybutton.titleLabel.font = Normal_Font;
        [copybutton setTitleColor:Text_Color forState:UIControlStateNormal];
        [copybutton addTarget:self action:@selector(copybtn) forControlEvents:UIControlEventTouchUpInside];
        copybutton.layer.cornerRadius = 12.5;
        copybutton.layer.borderColor = Line_Color.CGColor;
        copybutton.layer.borderWidth = 0.5;
        [backView addSubview:copybutton];

        UIImageView *backview2 = IMAGE_WITH_RECT(10, backView.bottom-15, ScreenWidth-20, 60);
        backview2.image = IMAGE_NAMED(@"Bitmap");
        backview2.layer.cornerRadius = 5;
        backview2.layer.masksToBounds = YES;
        [backView addSubview:backview2];

        _money1 = LABEL_WITH_RECT(0, 10, backview2.width/2, 20);
        _money1.text = @"0.00";
        _money1.textAlignment = NSTextAlignmentCenter;
        _money1.font = Normal_Font;
        _money1.textColor = white_Color;
        [backview2 addSubview:_money1];

        UILabel *lab2 = LABEL_WITH_RECT(0, _money1.bottom, backview2.width/2, 20);
        lab2.text = @"本月预估";
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.font = Tiny_Font;
        lab2.textColor = white_Color;
        [backview2 addSubview:lab2];

        UIView *line = VIEW_WITH_RECT(backview2.width/2, 10, 2, backview2.height-20);
        line.backgroundColor = Line_Color;
        line.layer.cornerRadius = 1;
        line.layer.masksToBounds = YES;
        [backview2 addSubview:line];

        _money2 = LABEL_WITH_RECT(backview2.width/2, 10, backview2.width/2, 20);
        _money2.text = @"0.00";
        _money2.textAlignment = NSTextAlignmentCenter;
        _money2.font = Normal_Font;
        _money2.textColor = white_Color;
        [backview2 addSubview:_money2];

        UILabel *lab4 = LABEL_WITH_RECT(backview2.width/2, _money2.bottom, backview2.width/2, 20);
        lab4.text = @"今日收益";
        lab4.textAlignment = NSTextAlignmentCenter;
        lab4.font = Tiny_Font;
        lab4.textColor = white_Color;
        [backview2 addSubview:lab4];
    }
    else{

        UILabel *_inviteCode = LABEL_WITH_RECT(_userImage.right+10, _username.bottom+10, 180, 20);
        _inviteCode.textColor = Text_Color;
        _inviteCode.font = Large_Font;
        _inviteCode.text = @"我的状态：普通用户";
        [backView addSubview:_inviteCode];

        backView.height = 130;
    }

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MAIN_HOST,CurrentUser.avatar]];

    [self.userImage sd_setImageWithURL:url placeholderImage:USER_PLACE_HOLDER_IMAGE];

    self.username.text = CurrentUser.name;
    self.inviteCode.text = [NSString stringWithFormat:@"邀请码:%@",CurrentUser.my_invite_code];

    return backView;
}

- (UIView *) createYu_eWithOffset:(float)offset
{
    UIView *backView = VIEW_WITH_RECT(10, offset+65, ScreenWidth-20, 150);
    backView.backgroundColor = white_Color;
    backView.layer.cornerRadius = 5;
//    [backView shadowWithColor:RGBA(0, 0, 0, 0.2) offset:CGSizeMake(5, 5) radius:5];

    if (!canShowAll) {

        backView.left = 0;
        backView.top = offset+12;
        backView.height = 100;
        backView.width = ScreenWidth;

        UIImageView *_bannerView2 = IMAGE_WITH_RECT(0, 0, ScreenWidth, 100);
        _bannerView2.userInteractionEnabled = YES;
        [backView addSubview:_bannerView2];

        _bannerView2.image = IMAGE_NAMED(@"userbanner");

        return backView;
    }

    self.allMoney = LABEL_WITH_RECT(30, 30, ScreenWidth, 20);
    self.allMoney.text = @"余额：¥20.00";
    self.allMoney.textColor = Text_Color;
    self.allMoney.font = Large_Font;
    [backView addSubview:self.allMoney];

//    UIButton *tixian = BUTTON_WITH_RECT(backView.width-70, _allMoney.top, 40, 20);
//    [tixian addTarget:self action:@selector(tixians) forControlEvents:UIControlEventTouchUpInside];
//    tixian.backgroundColor = RGB(0, 0, 0);
//    [tixian setTitle:@"提现" forState:UIControlStateNormal];
//    tixian.titleLabel.font = Small_Font;
//    tixian.layer.cornerRadius = 5;
//    tixian.layer.masksToBounds = YES;
//    [backView addSubview:tixian];

    UIView *line = VIEW_WITH_RECT(30, _allMoney.bottom+3, backView.width-60, 0.5);
    line.backgroundColor = Line_Color;
    [backView addSubview:line];

    UILabel *lab4 = LABEL_WITH_RECT(30, line.bottom, backView.width-60, 20);
    lab4.text = @"每月25号后可以提现";
    lab4.font = Tiny_Font;
    lab4.textColor = Text_Color;
    [backView addSubview:lab4];

    NSArray *textArray = @[@"收益",@"淘宝授权",@"好友"];
    float cellWidth = backView.width/textArray.count;

    for (int i = 0; i<textArray.count; i++) {

        UIView *cellBack = VIEW_WITH_RECT(cellWidth*i, lab4.bottom, cellWidth, cellWidth);
        cellBack.tag = 2000+i;
        [cellBack addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoriesClick:)]];
        [backView addSubview:cellBack];

        UIImageView *image = IMAGE_WITH_RECT((cellWidth-20)/2, 20, 20, 20);
        image.image = IMAGE_NAMED(textArray[i]);
        image.contentMode = UIViewContentModeScaleAspectFit;
        [cellBack addSubview:image];

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, image.bottom+5, cellWidth, 20)];
        lab.font = Small_Font;
        lab.textColor = [UIColor blackColor];
        lab.text = textArray[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.layer.cornerRadius = 12.5;
        lab.layer.masksToBounds = YES;
        [cellBack addSubview:lab];
    }

    return backView;
}

- (UIView *) createThirdWithOffset:(float)offset
{
    NSArray *textArray;
    if (canShowAll) {

        textArray = @[@"最近访问",@"专属海报"];//@"收藏宝贝",
    }
    else{

        textArray = @[@"最近访问",@"问题反馈",@"设置"];
    }

    NSMutableArray *array = [NSMutableArray arrayWithArray:textArray];
    if (!CurrentUser.weixin) {

        [array addObject:@"微信绑定"];
    }

    [_thirdBackView removeFromSuperview];

    _thirdBackView = VIEW_WITH_RECT(10, offset+25, ScreenWidth-20, array.count*40);
    _thirdBackView.backgroundColor = white_Color;
    _thirdBackView.layer.cornerRadius = 5;
//    [backView shadowWithColor:RGBA(0, 0, 0, 0.2) offset:CGSizeMake(5, 5) radius:5];

    for (int i = 0; i<array.count; i++) {

        UIView *cellBack = VIEW_WITH_RECT(0, 40*i, _thirdBackView.width, 40);
        cellBack.tag = 3000+i;
        [cellBack addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toolClick:)]];
        [_thirdBackView addSubview:cellBack];

        UIImageView *image = IMAGE_WITH_RECT(20, 10, 20, 20);
        image.image = IMAGE_NAMED(array[i]);
        image.contentMode = UIViewContentModeScaleAspectFit;
        [cellBack addSubview:image];

        UILabel *lab = LABEL_WITH_RECT(image.right+20, image.top, cellBack.width, 20);
        lab.font = Normal_Font;
        lab.textColor = [UIColor blackColor];
        lab.text = array[i];
        lab.layer.cornerRadius = 12.5;
        lab.layer.masksToBounds = YES;
        [cellBack addSubview:lab];

        UIImageView *arrow = IMAGE_WITH_RECT(_thirdBackView.width-20, 15, 6, 10);
        arrow.image = IMAGE_NAMED(@"nav_right_gray");
        [cellBack addSubview:arrow];

        if (i != array.count - 1) {

            UIView *line = VIEW_WITH_RECT(60, cellBack.height-0.5, _thirdBackView.width-40, 0.5);
            line.backgroundColor = Line_Color;
            [cellBack addSubview:line];
        }
    }

    return _thirdBackView;
}

- (void) getData
{
    [CurrentUser getUserInfoWithCallBack:^(NSDictionary *dict) {

        [self.scroll.mj_header endRefreshing];

        if (dict) {

            [CurrentUser safeSetWithDict:dict];

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",CurrentUser.avatar]];

            [self.userImage sd_setImageWithURL:url placeholderImage:USER_PLACE_HOLDER_IMAGE];

            self.username.text = CurrentUser.name;
            self.inviteCode.text = [NSString stringWithFormat:@"邀请码:%@",CurrentUser.my_invite_code];

            self.money1.text = [NSString stringWithFormat:@"%@",dict[@"incomeSum"][@"this_month_estimate"]];
            self.money2.text = [NSString stringWithFormat:@"%@",dict[@"incomeSum"][@"estimate_amount"]];
            self.allMoney.text = [NSString stringWithFormat:@"余额：¥%@",CurrentUser.available_balance];

            UIView *view3 = [self createThirdWithOffset:self.totalHeight];
            [self.scroll addSubview:view3];

            self.scroll.contentSize = CGSizeMake(ScreenWidth, self.totalHeight+view3.height);
        }
    }];
}

#pragma mark - 按钮事件
- (void) modiuser
{

}

- (void) copybtn
{
    [UIPasteboard generalPasteboard].string = self.inviteCode.text;

    SHOW_SUCCESS_MESSAGE(@"邀请码已复制到剪切板中！");
}

- (void) tixians
{

}

- (void) categoriesClick:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 2000;


}

- (void) toolClick:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 3000;

    NSArray *textArray;
    if (canShowAll) {

        textArray = @[@"最近访问",@"专属海报"];//@"收藏宝贝",
    }
    else{

        textArray = @[@"最近访问",@"问题反馈",@"用户设置"];
    }

    NSMutableArray *array = [NSMutableArray arrayWithArray:textArray];
    if (!CurrentUser.weixin) {
        [array addObject:@"微信绑定"];
    }
}

@end
