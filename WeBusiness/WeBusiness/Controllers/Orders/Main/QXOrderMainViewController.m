//
//  QXOrderMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderMainViewController.h"
#import "QXOrderModel.h"
#import "QXOrderGoodsModel.h"
#import "QXOrderMainCell.h"
#import "QXOrderHeaderView.h"
#import "QXOrderFooterView.h"


static NSString *identifier = @"QXOrderMainCell";
static NSString *identifierHeader = @"QXOrderHeaderView";
static NSString *identifierFooter = @"QXOrderFooterView";

@interface QXOrderMainViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation QXOrderMainViewController



- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXOrderModel *model = [[QXOrderModel alloc] init];
    model.name = @"李连杰";
    model.tel = @"18612341234";
    model.address = @"北京市西城区西四东大街100号4号楼3单元101室";
    model.cn = @"1022949701";
    model.remark = @"加急";
    model.buyerOrderTime = CFAbsoluteTimeGetCurrent();
    model.freight = 8.0f;
    model.cost = 100.0f;
    model.price = 200.0f;
    model.profit = model.price-model.cost-model.freight;
    model.isFinish = NO;
    
    
    QXOrderGoodsModel *orderGoodsModel = [[QXOrderGoodsModel alloc] init];
    orderGoodsModel.orderID = model.ID;
    orderGoodsModel.goodsID = @"8CF0E569-D0A9-4021-B3B6-E4623F8C8D4F";
    orderGoodsModel.buyCount = 3;
    orderGoodsModel.adjustCost = 0;
    orderGoodsModel.adjustPrice = 0;
    [orderGoodsModel store];
    [model.orderGoodsList addObject:orderGoodsModel];
    
    [model store];
    [self.dataArray addObject:model];
    [self.tableView reloadData];
}


- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    QXOrderModel *model = [[QXOrderModel alloc] init];
    NSArray *models = [model fetchAll];
    [models enumerateObjectsUsingBlock:^(QXOrderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QXOrderGoodsModel *orderGoodsModel = [[QXOrderGoodsModel alloc] init];
        NSArray *orderGoodsList = [orderGoodsModel fetchWithOrderID:obj.ID];
        obj.orderGoodsList = [NSMutableArray arrayWithArray:orderGoodsList];
        [self.dataArray addObject:obj];
    }];
}



- (void)loadUI
{
    self.title = @"订单";
    self.tableView.tableFooterView = [UIView new];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 125.0;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 60;
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 60;
    
    [self.tableView registerClass:[QXOrderHeaderView class] forHeaderFooterViewReuseIdentifier:identifierHeader];
    [self.tableView registerClass:[QXOrderFooterView class] forHeaderFooterViewReuseIdentifier:identifierFooter];
    [self.tableView registerClass:[QXOrderMainCell class] forCellReuseIdentifier:identifier];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}








#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QXOrderModel *model = self.dataArray[section];
    return model.orderGoodsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXOrderMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    QXOrderModel *model = self.dataArray[indexPath.section];
    cell.indexPath = indexPath;
    cell.orderGoodsModel = model.orderGoodsList[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QXOrderHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierHeader];
    view.orderModel = self.dataArray[section];
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    QXOrderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierFooter];
    view.orderModel = self.dataArray[section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    QXGoodsModel *model = self.dataArray[indexPath.row];
    QXGoodsDetailViewController *vc = [[QXGoodsDetailViewController alloc] initWithGid:model.ID];
    vc.hidesBottomBarWhenPushed = YES;
    vc.templateType = TemplateType_Display;
    [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
        //保存
        ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
        [self loadData];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
     */
}


@end
