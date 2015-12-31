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

#import "QXSearchResultViewController.h"

static NSString *identifier = @"QXCustomerMainCell";

@interface QXCustomerMainViewController ()
<UISearchBarDelegate,
UISearchResultsUpdating,
UISearchControllerDelegate,
QXSearchResultViewControllerDelegate>
@property (strong, nonatomic, nullable) NSMutableArray *dataArray;
@property (strong, nonatomic, nullable) NSArray *pySortArray;
@property (strong, nonatomic, nonnull) UISearchController *searchController;
@property (strong, nonatomic, nonnull) QXSearchResultViewController *srvc;
@end

@implementation QXCustomerMainViewController





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
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[QXCustomerMainCell class] forCellReuseIdentifier:identifier];
    
    
    
    self.srvc = [[QXSearchResultViewController alloc] initWithStyle:UITableViewStyleGrouped searchType:SearchType_Customer];
    self.srvc.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.srvc];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"搜索人名/地址/电话";
    self.tableView.tableHeaderView = self.searchController.searchBar;
}



- (void)loadData
{
    QXCustomerModel *model = [[QXCustomerModel alloc] init];
    self.dataArray = [NSMutableArray arrayWithArray:[model fetchAll]];
    self.pySortArray = [model fetchPinYinSortArray];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXCustomerMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.customerModel = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.dataArray[section] lastObject] pySort];
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.pySortArray;
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
        QXCustomerModel *model = self.dataArray[indexPath.section][indexPath.row];
        [model remove];
        [self.dataArray[indexPath.section] removeObject:model];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type==Type2_Display)
    {
        QXCustomerModel *model = self.dataArray[indexPath.section][indexPath.row];
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
        QXCustomerModel *model = self.dataArray[indexPath.section][indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(vc:selectedCustomer:)])
        {
            [self.delegate vc:self selectedCustomer:model];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}













#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    QXLog(@"search:%@",[searchController.searchBar.text lowercaseString]);
    QXCustomerModel *customeerModel = [[QXCustomerModel alloc] init];
    NSArray *models = [customeerModel fetchWithKeyword:[searchController.searchBar.text lowercaseString]];
    self.srvc.resultArray = [NSMutableArray arrayWithArray:models];
}












#pragma mark - QXSearchResultViewControllerDelegate
- (void)cancelKeyboard
{
    [self.searchController.searchBar resignFirstResponder];
}


- (void)selectModel:(id)model
{
    QXCustomerModel *customerModel = (QXCustomerModel*)model;
    self.searchController.active = NO;
    if (self.type==Type2_Display)
    {
        QXCustomerDetailViewController *customerDetailViewController = [[QXCustomerDetailViewController alloc] init];
        customerDetailViewController.templateType = TemplateType_Edit;
        customerDetailViewController.uid = customerModel.ID;
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(vc:selectedCustomer:)])
        {
            [self.delegate vc:self selectedCustomer:customerModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
