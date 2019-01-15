//
//  WSearchFilterView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/22.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WSearchFilterViewDelegate <NSObject>

/**
 排序按钮点击

 @param tag 需要排序字段
 @param asc 是否时正序
 */
- (void) sortWithTag:(NSString *)tag asc:(BOOL)asc;

@end

@interface WSearchFilterView : UIScrollView

@property (nonatomic,weak) id<WSearchFilterViewDelegate> searchDelegate;

/**
 初始化

 @param titleArray 排序字段
 @return 返回实例化对象
 */
- (instancetype) initWithTitleArray:(NSArray *)titleArray;

@end

NS_ASSUME_NONNULL_END
