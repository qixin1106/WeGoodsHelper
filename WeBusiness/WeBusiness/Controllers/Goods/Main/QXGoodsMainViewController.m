//
//  QXGoodsMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsMainViewController.h"

#import "QXGoodsModel.h"

@interface QXGoodsMainViewController ()
@property (strong, nonatomic, nonnull) NSMutableArray *dataArray;
@end

@implementation QXGoodsMainViewController






- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
    goodsModel.name = @"宝宝玩具";
    goodsModel.costPrice = 100.00;
    goodsModel.delegatePrice = 140.00;
    goodsModel.friendPrice = 130.00;
    goodsModel.retailPrice = 150.00;
    goodsModel.count = 50;
    goodsModel.descs = @"宝宝一玩就不苦,安全卫生不伤手.";
    goodsModel.picID = nil;
    goodsModel.remark = @"XXX进货";
    [goodsModel store];
    
    [self.tableView reloadData];
}

- (void)loadData
{
    QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
    self.dataArray = [NSMutableArray arrayWithArray:[goodsModel fetchAll]];
}

- (void)loadUI
{
    self.title = @"商品";
    self.tableView.tableFooterView = [UIView new];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}







/*
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXCustomerMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.customerModel = self.dataArray[indexPath.row];
    return cell;
}
*/


@end
