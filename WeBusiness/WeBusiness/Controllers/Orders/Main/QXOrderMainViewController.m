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
#import "QXSearchResultViewController.h"

static NSString *identifier = @"QXOrderMainCell";
static NSString *identifierHeader = @"QXOrderHeaderView";
static NSString *identifierFooter = @"QXOrderFooterView";

@interface QXOrderMainViewController ()
<QXOrderDetailViewControllerDelegate,
QXOrderFooterViewDelegate,
UISearchBarDelegate,
UISearchResultsUpdating,
UISearchControllerDelegate,
QXSearchResultViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic, nonnull) UISearchController *searchController;
@property (strong, nonatomic, nonnull) QXSearchResultViewController *srvc;
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
    
    
    
    self.srvc = [[QXSearchResultViewController alloc] initWithStyle:UITableViewStyleGrouped searchType:SearchType_Order];
    self.srvc.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.srvc];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"搜索人名/地址/电话";
    self.tableView.tableHeaderView = self.searchController.searchBar;
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
    view.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    QXOrderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierFooter];
    view.orderModel = self.dataArray[section];
    view.delegate = self;
    view.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}













- (void)orderDetail:(QXOrderDetailViewController*)vc onSaveModel:(QXOrderModel*)orderModel;
{
    //新增
    if (vc.templateType==TemplateType_Add)
    {
        [self.dataArray insertObject:orderModel atIndex:0];
        [self.tableView reloadData];
        return;
    }
    
    //编辑
    if (vc.templateType==TemplateType_Edit)
    {
        [self.dataArray replaceObjectAtIndex:vc.indexPath.section withObject:orderModel];
        [self.tableView reloadData];
        return;
    }
}

















#pragma mark - QXOrderFooterViewDelegate
- (void)footerViewOnClickRemoveOrder:(QXOrderFooterView*)footer
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否删除订单" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertDel = [UIAlertAction actionWithTitle:@"删除订单"
                                                       style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * _Nonnull action)
                               {
                                   QXOrderModel *model = self.dataArray[footer.indexPath.section];
                                   [model.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                       [obj remove];
                                   }];
                                   [self.dataArray removeObject:model];
                                   [model remove];
                                   [self.tableView reloadData];
                               }];
    [alertController addAction:alertDel];
    
    UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:alertCancel];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}



- (void)footerViewOnClickEditOrder:(QXOrderFooterView*)footer
{
    QXOrderDetailViewController *vc = [[QXOrderDetailViewController alloc] init];
    vc.delegate = self;
    vc.templateType = TemplateType_Edit;
    vc.orderID = footer.orderModel.ID;
    vc.indexPath = footer.indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}



















#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    QXLog(@"search:%@",[searchController.searchBar.text lowercaseString]);
    QXOrderModel *orderModel = [[QXOrderModel alloc] init];
    NSArray *models = [orderModel fetchWithKeyword:[searchController.searchBar.text lowercaseString]];
    [models enumerateObjectsUsingBlock:^(QXOrderModel * _Nonnull orderModel, NSUInteger idx, BOOL * _Nonnull stop) {
        QXOrderGoodsModel *goodsModel = [[QXOrderGoodsModel alloc] init];
        NSArray *goodsList = [goodsModel fetchWithOrderID:orderModel.ID];
        orderModel.orderGoodsList = [goodsList mutableCopy];
    }];
    self.srvc.resultArray = [NSMutableArray arrayWithArray:models];
}












#pragma mark - QXSearchResultViewControllerDelegate
- (void)cancelKeyboard
{
    [self.searchController.searchBar resignFirstResponder];
}


- (void)selectModel:(id)model
{
    /*
    QXOrderModel *orderModel = (QXOrderModel*)model;
    self.searchController.active = NO;
    if (self.type==OrderMainType_Display)
    {
        QXOrderDetailViewController *vc = [[QXOrderDetailViewController alloc] init];
        vc.delegate = self;
        vc.templateType = TemplateType_Edit;
        vc.orderID = orderModel.ID;
        vc.indexPath = footer.indexPath;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.type==OrderMainType_Select)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(vc:selectedOrder:)])
        {
            [self.delegate vc:self selectedOrder:orderModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
     */
}



@end
