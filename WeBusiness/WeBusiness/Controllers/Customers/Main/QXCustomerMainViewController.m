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




//- (void)onBackClick:(UIBarButtonItem*)sender
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}

- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXCustomerDetailViewController *customerDetailViewController = [[QXCustomerDetailViewController alloc] init];
    customerDetailViewController.templateType = TemplateType_Add;
    [customerDetailViewController setSaveCustomerBlock:^(QXCustomerModel *customerModel){
        //保存
        ([customerModel fetchModel])?[customerModel refresh]:[customerModel store];
        [self loadData];
        [self.tableView reloadData];
    }];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:customerDetailViewController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}


- (void)loadUI
{
    self.title = (self.type==Type2_Display)?@"客户":@"选择客户";
    
//    if (self.type==Type2_Select)
//    {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClick:)];
//        self.navigationItem.leftBarButtonItems = @[leftItem];
//    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    
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
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        QXCustomerModel *model = self.dataArray[indexPath.row];
        [model remove];
        [self.dataArray removeObject:model];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type==Type2_Display)
    {
        QXCustomerModel *model = self.dataArray[indexPath.row];
        QXCustomerDetailViewController *customerDetailViewController = [[QXCustomerDetailViewController alloc] init];
        customerDetailViewController.templateType = TemplateType_Edit;
        customerDetailViewController.uid = model.ID;
        [customerDetailViewController setSaveCustomerBlock:^(QXCustomerModel *customerModel){
            //保存
            ([customerModel fetchModel])?[customerModel refresh]:[customerModel store];
            [self loadData];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:customerDetailViewController animated:YES];
    }
    
    if (self.type==Type2_Select)
    {
        QXCustomerModel *model = self.dataArray[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(vc:selectedCustomer:)])
        {
            [self.delegate vc:self selectedCustomer:model];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
