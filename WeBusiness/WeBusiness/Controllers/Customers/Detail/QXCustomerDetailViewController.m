//
//  QXCustomerDetailViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerDetailViewController.h"
#import "QXCustomerDetailHeadCell.h"
//Model
#import "QXCustomerModel.h"
#import "QXCustomerModel+TypeTranslation.h"

#import "QXInputStringViewController.h"

static NSString *identifier = @"QXCustomerDetailHeadCell";



@interface QXCustomerDetailViewController ()
@property (strong, nonatomic) QXCustomerModel *customerModel;
@property (strong, nonatomic) NSArray *headerTitles;
@end
@implementation QXCustomerDetailViewController


- (void)storeModel
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool
        {
            if (self.customerModel)
            {
                [self.customerModel store];
            }
        }
    });
}


- (void)onAddClick:(UIBarButtonItem*)sender
{
    if (self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onAddClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onAddClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}


- (void)loadUI
{
    self.title = @"客户详情";
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onAddClick:)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[QXCustomerDetailHeadCell class] forCellReuseIdentifier:identifier];
}



- (void)loadData
{
    self.headerTitles = @[@"姓名",@"手机",@"地址",@"微信号",@"关系"];
    QXCustomerModel *model = [[QXCustomerModel alloc] init];
    model.uid = self.uid;
    self.customerModel = [model fetchModel];
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
    return self.headerTitles.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headerTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXCustomerDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.section==0)
    {
        cell.textLabel.text = self.customerModel.name;
    }
    else if (indexPath.section==1)
    {
        cell.textLabel.text = self.customerModel.tel;
    }
    else if (indexPath.section==2)
    {
        cell.textLabel.text = self.customerModel.address;
    }
    else if (indexPath.section==3)
    {
        cell.textLabel.text = self.customerModel.wechatID;
    }
    else if (indexPath.section==4)
    {
        cell.textLabel.text = [self.customerModel typeToString];
    }
    return cell;
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXInputStringViewController *inputStringViewController = [[QXInputStringViewController alloc] init];
    if (indexPath.section==0)
    {
        inputStringViewController.placeHolder = self.customerModel.name;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.customerModel.name = string;
            [self storeModel];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    else if (indexPath.section==1)
    {
        inputStringViewController.placeHolder = self.customerModel.tel;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.customerModel.tel = string;
            [self storeModel];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    else if (indexPath.section==2)
    {
        inputStringViewController.placeHolder = self.customerModel.address;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.customerModel.address = string;
            [self storeModel];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    else if (indexPath.section==3)
    {
        inputStringViewController.placeHolder = self.customerModel.wechatID;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.customerModel.wechatID = string;
            [self storeModel];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    else if (indexPath.section==4)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"设置关系" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"客户"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            self.customerModel.type = 0;
                                                            [self storeModel];
                                                            [self.tableView beginUpdates];
                                                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                                                            [self.tableView endUpdates];
                                                        }];
        [alertController addAction:action0];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"代理"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            self.customerModel.type = 1;
                                                            [self storeModel];
                                                            [self.tableView beginUpdates];
                                                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                                                            [self.tableView endUpdates];
                                                        }];
        [alertController addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"朋友"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            self.customerModel.type = 2;
                                                            [self storeModel];
                                                            [self.tableView beginUpdates];
                                                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                                                            [self.tableView endUpdates];
                                                        }];
        [alertController addAction:action2];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                       }];
        [alertController addAction:action3];
        [self presentViewController:alertController animated:YES completion:NULL];
    }
}











#pragma mark - QXInputStringViewControllerDelegate
@end
