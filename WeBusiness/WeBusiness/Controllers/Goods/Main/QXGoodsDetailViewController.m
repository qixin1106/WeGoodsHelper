//
//  QXGoodsDetailViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsDetailViewController.h"
#import "QXGoodsModel.h"
#import "QXGoodsModel+Utils.h"

#import "QXInputStringViewController.h"

static NSString *identifier = @"UITableViewCell";


@interface QXGoodsDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (copy, nonatomic) NSString *gid;
@property (strong, nonatomic) QXGoodsModel *goodsModel;
@property (strong, nonatomic) NSArray *headerTitles;
@end

@implementation QXGoodsDetailViewController










- (void)onSaveClick:(UIBarButtonItem*)sender
{
    if (self.saveGoodsBlock)
    {
        self.saveGoodsBlock(self.goodsModel);
    }
    (self.templateType==TemplateType_Display)?[self.navigationController popViewControllerAnimated:YES]:[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onBackClick:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)loadData
{
    if (self.templateType==TemplateType_Display)
    {
        QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
        goodsModel.ID = self.gid;
        self.goodsModel = [goodsModel fetchModel];
    }
    else
    {
        self.goodsModel = [[QXGoodsModel alloc] init];
    }
}

- (void)loadUI
{
    self.headerTitles = @[@"名称",@"进价",@"单价",@"代理价",@"友情价",@"数量",@"描述",@"备注"];
    self.title = (self.templateType==TemplateType_Display)?@"商品详情":@"添加商品";
    self.tableView.tableFooterView = [UIView new];
    
    if (self.templateType==TemplateType_Add)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSaveClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}



- (instancetype)initWithGid:(NSString*)gid
{
    self = [super init];
    if (self)
    {
        self.gid = gid;
    }
    return self;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0)
    {
        cell.textLabel.text = self.goodsModel.name;
    }
    else if (indexPath.section==1)
    {
        cell.textLabel.text = [self.goodsModel costPriceToString];
    }
    else if (indexPath.section==2)
    {
        cell.textLabel.text = [self.goodsModel retailPriceToString];
    }
    else if (indexPath.section==3)
    {
        cell.textLabel.text = [self.goodsModel delegatePriceToString];
    }
    else if (indexPath.section==4)
    {
        cell.textLabel.text = [self.goodsModel friendPriceToString];
    }
    else if (indexPath.section==5)
    {
        cell.textLabel.text = [self.goodsModel countToString];
    }
    else if (indexPath.section==6)
    {
        cell.textLabel.text = self.goodsModel.descs;
    }
    else if (indexPath.section==7)
    {
        cell.textLabel.text = self.goodsModel.remark;
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
        inputStringViewController.placeHolder = self.goodsModel.name;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.name = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==1)
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel costPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.costPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==2)
    {
        inputStringViewController.placeHolder = [self.goodsModel retailPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.retailPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==3)
    {
        inputStringViewController.placeHolder = [self.goodsModel delegatePriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.delegatePrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==4)
    {
        inputStringViewController.placeHolder = [self.goodsModel friendPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.friendPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==5)
    {
        inputStringViewController.placeHolder = [self.goodsModel countToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.count = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==6)
    {
        inputStringViewController.placeHolder = self.goodsModel.descs;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.descs = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
    if (indexPath.section==7)
    {
        inputStringViewController.placeHolder = self.goodsModel.remark;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.remark = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }];
    }
}


@end
