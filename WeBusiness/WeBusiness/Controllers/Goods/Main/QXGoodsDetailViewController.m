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
#import "QXGoodsDetailTextCell.h"

#import "QXGoodsDetailTableViewHeaderView.h"

static NSString *identifier = @"QXGoodsDetailTextCell";

@interface QXGoodsDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (copy, nonatomic) NSString *gid;
@property (strong, nonatomic) QXGoodsModel *goodsModel;
@property (strong, nonatomic) NSArray *headerTitles;
@property (strong, nonatomic) QXGoodsDetailTableViewHeaderView *imgHeadView;
@end

@implementation QXGoodsDetailViewController






- (void)saveModel
{
    if (VALID_STRING(self.goodsModel.name))
    {
        if (self.saveGoodsBlock)
        {
            self.saveGoodsBlock(self.goodsModel);
        }
    }
    else
    {
        ALERT(@"请先写商品名称,否则无法保存", nil);
    }
}



- (void)onSaveClick:(UIBarButtonItem*)sender
{
    if (VALID_STRING(self.goodsModel.name))
    {
        if (self.saveGoodsBlock)
        {
            self.saveGoodsBlock(self.goodsModel);
        }
        (self.templateType==TemplateType_Display)?[self.navigationController popViewControllerAnimated:YES]:[self dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
        ALERT(@"没写商品名称", nil);
    }
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
    self.headerTitles = @[@"名称(必填)",@"进价",@"单价",@"代理价",@"友情价",@"数量",@"描述",@"备注"];
    self.title = (self.templateType==TemplateType_Display)?@"商品详情":@"添加商品";
    if (self.templateType==TemplateType_Add)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSaveClick:)];
//    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    
    
    //Table
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QXGoodsDetailTextCell class] forCellReuseIdentifier:identifier];
    
    
    //Header
    self.imgHeadView = [[QXGoodsDetailTableViewHeaderView alloc] init];
    self.imgHeadView.picID = self.goodsModel.picID;
    self.tableView.tableHeaderView = self.imgHeadView;

    //Footer
    self.tableView.tableFooterView = [UIView new];
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
    QXGoodsDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0)//商品名
    {
        cell.titleLabel.text = self.goodsModel.name;
    }
    else if (indexPath.section==1)//进价
    {
        cell.titleLabel.text = [self.goodsModel costPriceToString];
    }
    else if (indexPath.section==2)//零售价
    {
        cell.titleLabel.text = [self.goodsModel retailPriceToString];
    }
    else if (indexPath.section==3)//代理价
    {
        cell.titleLabel.text = [self.goodsModel delegatePriceToString];
    }
    else if (indexPath.section==4)//友情价
    {
        cell.titleLabel.text = [self.goodsModel friendPriceToString];
    }
    else if (indexPath.section==5)//数量
    {
        cell.titleLabel.text = [self.goodsModel countToString];
    }
    else if (indexPath.section==6)//描述
    {
        cell.titleLabel.text = self.goodsModel.descs;
    }
    else if (indexPath.section==7)//备注
    {
        cell.titleLabel.text = self.goodsModel.remark;
    }
    return cell;
}







#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXInputStringViewController *inputStringViewController = [[QXInputStringViewController alloc] init];
    if (indexPath.section==0)//商品名
    {
        inputStringViewController.placeHolder = self.goodsModel.name;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.name = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==1)//进价
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel costPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.costPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==2)//零售
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel retailPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.retailPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==3)//代理
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel delegatePriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.delegatePrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==4)//友情
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel friendPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.friendPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==5)//数量
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel countToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.count = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==6)//描述
    {
        inputStringViewController.placeHolder = self.goodsModel.descs;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.descs = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==7)//备注
    {
        inputStringViewController.placeHolder = self.goodsModel.remark;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.remark = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
}


@end
