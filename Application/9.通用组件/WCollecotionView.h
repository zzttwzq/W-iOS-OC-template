//
//  WCollecotionView.h
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/24.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WCollecotionViewDelegate <NSObject>

- (CGSize) setCellSize;

- (UIEdgeInsets) setCellMargin;

- (UICollectionViewCell *) setCellWitchColleciton:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath;

- (void) clickItemWithData:(id)data indexPath:(NSIndexPath *)indexPath;

@end

@interface WCollecotionView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak) id<WCollecotionViewDelegate> delegate;

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) UIView *collectionHeader;

@property (nonatomic,strong) UIView *noDataView;

@property (nonatomic,copy) NSArray *listArray;


- (instancetype) initWithFrame:(CGRect)frame
                        layout:(UICollectionViewFlowLayout * _Nullable)layout
                      cellName:(NSString *)cellName;

@end

NS_ASSUME_NONNULL_END
