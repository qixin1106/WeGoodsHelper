//
//  QXSearchResultViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/29.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXSearchResultViewController.h"
#import "QXCustomerMainCell.h"

static NSString *identifier = @"QXCustomerMainCell";

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
    [self.tableView registerClass:[QXCustomerMainCell class] forCellReuseIdentifier:identifier];
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
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"最佳匹配";
}



#pragma mark - UITableViewDelegate
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCustomer:)])
    {
        [self.delegate selectCustomer:self.resultArray[indexPath.row]];
    }
}


@end
