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
#import "QXOrderDetailViewController.h"

static NSString *identifier = @"QXOrderMainCell";
static NSString *identifierHeader = @"QXOrderHeaderView";
static NSString *identifierFooter = @"QXOrderFooterView";

@interface QXOrderMainViewController ()
<QXOrderDetailViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation QXOrderMainViewController



- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXOrderDetailViewController *vc = [[QXOrderDetailViewController alloc] init];
    vc.delegate = self;
    vc.templateType = TemplateType_Add;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:NULL];
    return;
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
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80.0;
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
    vc.templateType = TemplateType_Edit;
    [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
        //保存
        ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
        [self loadData];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
     */
}













- (void)onSaveModel:(QXOrderModel*)orderModel
{
    [self.dataArray insertObject:orderModel atIndex:0];
    [self.tableView reloadData];
}


@end
