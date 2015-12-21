//
//  QXCustomerMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerMainViewController.h"

#import "QXCustomerModel.h"

#import "QXCustomerMainCell.h"

#import "QXCustomerDetailViewController.h"

static NSString *identifier = @"QXCustomerMainCell";

@interface QXCustomerMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic, nonnull) NSMutableArray *dataArray;
@end

@implementation QXCustomerMainViewController






- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXCustomerModel *model = [[QXCustomerModel alloc] init];
    model.name = @"神秘人";
    model.tel = @"18612341234";
    model.address = @"宇宙太阳系地球亚洲中国北京宇宙太阳系地球亚洲中国北京宇宙太阳系地球亚洲中国北京";
    model.wechatID = @"helloworld";
    model.type = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool
        {
            [model store];
        }
    });
    
    [self.dataArray insertObject:model atIndex:0];
    //刷新UI
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}


- (void)loadUI
{
    self.title = @"客户";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[QXCustomerMainCell class] forCellReuseIdentifier:identifier];
}



- (void)loadData
{
    QXCustomerModel *model = [[QXCustomerModel alloc] init];
    self.dataArray = [NSMutableArray arrayWithArray:[model fetchAll]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}









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



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXCustomerDetailViewController *customerDetailViewController = [[QXCustomerDetailViewController alloc] init];
    customerDetailViewController.hidesBottomBarWhenPushed = YES;
    QXCustomerModel *model = self.dataArray[indexPath.row];
    customerDetailViewController.uid = model.uid;
    [self.navigationController pushViewController:customerDetailViewController animated:YES];
}


@end
