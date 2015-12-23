//
//  QXGoodsMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsMainViewController.h"

#import "QXGoodsModel.h"
#import "QXGoodsMainCell.h"

#import "QXGoodsDetailViewController.h"

static NSString *identifier = @"QXGoodsMainCell";

@interface QXGoodsMainViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic, nonnull) NSMutableArray *dataArray;
@end

@implementation QXGoodsMainViewController






- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXGoodsDetailViewController *vc = [[QXGoodsDetailViewController alloc] initWithGid:nil];
    vc.templateType = TemplateType_Add;
    [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
        //保存
        ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
        [self loadData];
        [self.tableView reloadData];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:NULL];    
}

- (void)loadData
{
    QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
    self.dataArray = [NSMutableArray arrayWithArray:[goodsModel fetchAll]];
}

- (void)loadUI
{
    self.title = @"库存";
    self.tableView.tableFooterView = [UIView new];
    self.hidesBottomBarWhenPushed = NO;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QXGoodsMainCell class] forCellReuseIdentifier:identifier];
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
    QXGoodsMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.goodsModel = self.dataArray[indexPath.row];
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
        QXGoodsModel *model = self.dataArray[indexPath.row];
        [model remove];
        [self.dataArray removeObject:model];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXGoodsModel *model = self.dataArray[indexPath.row];
    QXGoodsDetailViewController *vc = [[QXGoodsDetailViewController alloc] initWithGid:model.ID];
    vc.hidesBottomBarWhenPushed = YES;
    vc.templateType = TemplateType_Display;
    [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
        //保存
        ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
        [self loadData];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
