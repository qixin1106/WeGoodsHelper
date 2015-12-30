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

static NSString *identifier = @"QXCustomerMainCell";
static NSString *identifier2 = @"QXGoodsMainCell";
static NSString *identifier3 = @"QXOrderMainCell";

@interface QXSearchResultViewController ()
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
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
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
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"最佳匹配";
}



#pragma mark - UITableViewDelegate
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
    return UITableViewAutomaticDimension;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)])
    {
        [self.delegate selectModel:self.resultArray[indexPath.row]];
    }
}


@end
