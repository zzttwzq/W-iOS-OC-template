//
//  WTitleBar.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/11/24.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WTitleBar : UIView
@property (nonatomic,copy) CountBlock selectIndex;

/**
 初始化界面

 @param array 初始化的数组
 @param selectIndex 选中第几个
 @return 返回界面
 */
-(instancetype)initWithArray:(NSArray *)array
                 selectIndex:(int)selectIndex;



/**
 设置位置

 @param index 位置编号
 */
-(void)setIndex:(int)index;


@end

NS_ASSUME_NONNULL_END
