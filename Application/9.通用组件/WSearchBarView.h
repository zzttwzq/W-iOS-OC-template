//
//  WSearchView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/22.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WSearchBarViewDelegate <NSObject>
/**
 当点击搜索栏时，推送到新的页面
 */
- (void) pushView;

/**
 开始搜索

 @param text 要搜索的标签
 */
- (void) didSearch:(NSString *)text;

@end

@interface WSearchBarView : UIView <UITextFieldDelegate>
@property (nonatomic,weak) id<WSearchBarViewDelegate> delegate;
@property (nonatomic,strong) UITextField *searchText;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;

@property (nonatomic,assign) BOOL disableTextFieldToPush;

@end

NS_ASSUME_NONNULL_END
