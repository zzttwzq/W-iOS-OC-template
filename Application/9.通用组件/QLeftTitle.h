//
//  QLeftTitle.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/9/30.
//  Copyright © 2018年 FengDing_Ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLeftTitle : UIView
/**
 重新制定位置
 */
@property (nonatomic,assign) int index;

/**
 回调
 */
@property (nonatomic,copy) CountBlock selectIndex;

/**
 数据列表
 */
@property (nonatomic,strong) NSArray *listArray;



/**
 初始化页面

 @param yOffset y轴高度
 @return 返回实例化对象
 */
- (instancetype) initWithOffset:(float)yOffset;

@end
