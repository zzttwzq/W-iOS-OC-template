//
//  WTableView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/24.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WTableViewDelegate <NSObject>

- (void) clickItemWithData:(id)data indexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *) setCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end

@interface WTableView : UIView
@property (nonatomic,weak) id<WTableViewDelegate> delegate;

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) NSArray *listArray;
@property (nonatomic,strong) UIView *noDataView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerVuew;
@property (nonatomic,assign) float cellHeight;

@property (nonatomic,assign) int page;
@property (nonatomic,assign) int total;

@end

NS_ASSUME_NONNULL_END
