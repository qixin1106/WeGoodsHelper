//
//  QXSearchResultViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/29.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXSearchResultViewController.h"
#import "QXCustomerMainCell.h"
#import "QXGoodsMainCell.h"
#import "QXOrderMainCell.h"
#import "QXOrderHeaderView.h"
#import "QXOrderFooterView.h"
#import "QXOrderModel.h"
#import "QXOrderGoodsModel.h"

static NSString *identifier = @"QXCustomerMainCell";
static NSString *identifier2 = @"QXGoodsMainCell";
static NSString *identifier3 = @"QXOrderMainCell";
static NSString *identifierHeader = @"QXOrderHeaderView";
static NSString *identifierFooter = @"QXOrderFooterView";

@interface QXSearchResultViewController ()
<QXOrderFooterViewDelegate>
@end

@implementation QXSearchResultViewController


- (void)setResultArray:(NSMutableArray *)resultArray
{
    if (_resultArray!=resultArray)
    {
        _resultArray=resultArray;
        [self.tableView reloadData];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    if (self.searchType==SearchType_Order)
    {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 80.0;
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 60;
        self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedSectionFooterHeight = 60;
    }
    else
    {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 60;
    }
    if (self.searchType==SearchType_Customer)
    {
        [self.tableView registerClass:[QXCustomerMainCell class] forCellReuseIdentifier:identifier];
    }
    else if (self.searchType==SearchType_Goods)
    {
        [self.tableView registerClass:[QXGoodsMainCell class] forCellReuseIdentifier:identifier2];
    }
    else if (self.searchType==SearchType_Order)
    {
        [self.tableView registerClass:[QXOrderMainCell class] forCellReuseIdentifier:identifier3];
        [self.tableView registerClass:[QXOrderHeaderView class] forHeaderFooterViewReuseIdentifier:identifierHeader];
        [self.tableView registerClass:[QXOrderFooterView class] forHeaderFooterViewReuseIdentifier:identifierFooter];
    }
}


- (instancetype)initWithStyle:(UITableViewStyle)style searchType:(SearchType)searchType
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.searchType = searchType;
        self.resultArray = [NSMutableArray array];
    }
    return self;
}






- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelKeyboard)])
    {
        [self.delegate cancelKeyboard];
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchType==SearchType_Order)
    {
        return self.resultArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchType==SearchType_Order)
    {
        QXOrderModel *model = self.resultArray[section];
        return model.orderGoodsList.count;
    }
    return self.resultArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType==SearchType_Customer)
    {
        QXCustomerMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.customerModel = self.resultArray[indexPath.row];
        return cell;
    }
    else if (self.searchType==SearchType_Goods)
    {
        QXGoodsMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2 forIndexPath:indexPath];
//        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.goodsModel = self.resultArray[indexPath.row];
        return cell;
    }
    else if (self.searchType==SearchType_Order)
    {
        QXOrderMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3 forIndexPath:indexPath];
        QXOrderModel *model = self.resultArray[indexPath.section];
        cell.indexPath = indexPath;
        cell.orderGoodsModel = model.orderGoodsList[indexPath.row];
        return cell;
    }
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchType==SearchType_Order)
    {
        return nil;
    }
    return @"最佳匹配";
}



#pragma mark - UITableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.searchType==SearchType_Order)
    {
        QXOrderHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierHeader];
        view.orderModel = self.resultArray[section];
        view.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return view;
    }
    return nil;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.searchType==SearchType_Order)
    {
        QXOrderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierFooter];
        view.orderModel = self.resultArray[section];
        view.delegate = self;
        view.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType==SearchType_Customer)
    {
        return UITableViewAutomaticDimension;
    }
    else if (self.searchType==SearchType_Goods)
    {
        return 125;
    }
    else if (self.searchType==SearchType_Order)
    {
        return 80;
    }
    return UITableViewAutomaticDimension;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchType==SearchType_Order)
    {
        return UITableViewAutomaticDimension;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.searchType==SearchType_Order)
    {
        return UITableViewAutomaticDimension;
    }
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType==SearchType_Order)
    {
        
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)])
        {
            [self.delegate selectModel:self.resultArray[indexPath.row]];
        }
    }
}

















#pragma mark - QXOrderFooterViewDelegate
- (void)footerViewOnClickRemoveOrder:(QXOrderFooterView*)footer
{
    /*
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否删除订单" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertDel = [UIAlertAction actionWithTitle:@"删除订单"
                                                       style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * _Nonnull action)
                               {
                                   QXOrderModel *model = self.resultArray[footer.indexPath.section];
                                   [model.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                       [obj remove];
                                   }];
                                   [self.resultArray removeObject:model];
                                   [model remove];
                                   
                                   
                                   [self.tableView beginUpdates];
                                   [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:footer.indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                                   [self.tableView endUpdates];
                               }];
    [alertController addAction:alertDel];
    
    UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:alertCancel];
    
    [self presentViewController:alertController animated:YES completion:NULL];
     */
}



- (void)footerViewOnClickEditOrder:(QXOrderFooterView*)footer
{
    /*
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)])
    {
        [self.delegate selectModel:self.resultArray[footer.indexPath.section]];
    }
     */
}



@end
