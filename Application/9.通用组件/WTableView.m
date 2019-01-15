


    //
//  WTableView.m
//  ZhiJianKe
//
//  Created by 吴志强 on 2018/12/24.
//  Copyright © 2018 Wuzhiqiang. All rights reserved.
//

#import "WTableView.h"

@interface WTableView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation WTableView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //3.数据列表页面
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = View_Back_Color;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.tableFooterView = [UIView new];
        [self addSubview:_table];
    }
    return self;
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

    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.listArray.count > 0) {
        self.noDataView.alpha = 0;
    }
    else{
        self.noDataView.alpha = 1;
    }

    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.delegate respondsToSelector:@selector(setCellWithTable:indexPath:)]) {

       return [self.delegate setCellWithTable:self.table indexPath:indexPath];
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return _cellHeight;
}


@end
