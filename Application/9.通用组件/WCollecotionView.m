//
//  WCollecotionView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/24.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WCollecotionView.h"



@implementation WCollecotionView

- (instancetype) initWithFrame:(CGRect)frame
                        layout:(UICollectionViewFlowLayout * _Nullable)layout
                      cellName:(NSString *)cellName;
{
    self = [super initWithFrame:frame];
    if (self) {

        UICollectionViewFlowLayout *_layout;
        if (!layout) {
            _layout = [UICollectionViewFlowLayout new];
        }
        else{
            _layout = layout;
        }

        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height) collectionViewLayout:_layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = View_Back_Color;
        _collection.showsVerticalScrollIndicator = NO;
        [self addSubview:_collection];

        //4.注册item和区头视图、区尾视图
        [_collection registerClass:[NSClassFromString(cellName) class] forCellWithReuseIdentifier:cellName];
    }
    return self;
}

- (void) setCollectionHeader:(UIView *)collectionHeader
{
    _collectionHeader = collectionHeader;

    _collectionHeader.top = -_collectionHeader.height;
    [_collection addSubview:_collectionHeader];

    _collection.mj_header.ignoredScrollViewContentInsetTop = _collectionHeader.height;
    _collection.contentOffset = CGPointMake(0, -_collectionHeader.height);
    _collection.contentInset = UIEdgeInsetsMake(-_collectionHeader.height, 0, 0, 0);
}

- (void) setListArray:(NSArray *)listArray
{
    _listArray = listArray;

    if (_noDataView) {

        if (_listArray.count > 0) {
            _noDataView.alpha = 0;
        }
        else{
            _noDataView.alpha = 1;
        }
    }

    [_collection reloadData];
}

#pragma mark - UICollectionViewDataSource
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(setCellWitchColleciton:indexPath:)]) {

        return [self.delegate setCellWitchColleciton:collectionView indexPath:indexPath];
    }

    return nil;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(setCellSize)]) {

        return [self.delegate setCellSize];
    }

    return CGSizeMake(0, 0);
}

//每个分区的内边距（上左下右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if ([self.delegate respondsToSelector:@selector(setCellSize)]) {

        return [self.delegate setCellMargin];
    }

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
