//
//  QXOrderDetailViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailViewController.h"
#import "QXGoodsModel.h"
#import "QXOrderModel.h"
#import "QXOrderGoodsModel.h"
#import "QXOrderDetailHeadView.h"
#import "QXOrderDetailFooterView.h"
#import "QXGoodsMainViewController.h"
#import "QXOrderDetailCell.h"
#import "QXCustomerModel.h"
#import "QXCustomerMainViewController.h"
#import "QXOrderDetailMoreView.h"


static NSString *identifier = @"QXOrderDetailCell";
static NSString *identifierHeader = @"QXOrderHeaderView";
static NSString *identifierFooter = @"QXOrderFooterView";


@interface QXOrderDetailViewController ()
<QXOrderDetailFooterViewDelegate,
QXGoodsMainViewControllerDelegate,
QXOrderDetailHeadViewDelegate,
QXCustomerMainViewControllerDelegate,
QXOrderDetailCellDelegate>
@property (strong, nonatomic) QXOrderModel *orderModel;
@property (strong, nonatomic) QXOrderDetailMoreView *moreView;
@end

@implementation QXOrderDetailViewController

- (void)removeMoreView
{
    if (self.moreView)
    {
        [self.moreView removeFromSuperview];
        self.moreView = nil;
    }
}



- (void)onBackClick:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onSaveClick:(UIBarButtonItem*)sender
{
    QXOrderDetailHeadView *header = (QXOrderDetailHeadView*)self.tableView.tableHeaderView;
    [header assignModel];
    
    [self.orderModel store];
    [self.orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj store];
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSaveModel:)])
    {
        [self.delegate onSaveModel:self.orderModel];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}




- (void)loadUI
{
    self.title = (self.templateType==TemplateType_Edit)?@"编辑订单":@"添加订单";
    if (self.templateType==TemplateType_Add)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSaveClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 125.0;
    [self.tableView registerClass:[QXOrderDetailCell class] forCellReuseIdentifier:identifier];
    
    QXOrderDetailHeadView *header = [[[NSBundle mainBundle] loadNibNamed:@"QXOrderDetailHeadView" owner:self options:nil] lastObject];
    header.orderModel = self.orderModel;
    header.delegate = self;
    self.tableView.tableHeaderView = header;
    
    QXOrderDetailFooterView *footer = [[[NSBundle mainBundle] loadNibNamed:@"QXOrderDetailFooterView" owner:self options:nil] lastObject];
    footer.orderModel = self.orderModel;
    footer.delegate = self;
    self.tableView.tableFooterView = footer;
    
}



- (void)loadData
{
    if (self.templateType==TemplateType_Edit)
    {
        QXOrderModel *model = [[QXOrderModel alloc] init];
        model.ID = self.orderID;
        self.orderModel = [model fetchModel];
    }
    else
    {
        self.orderModel = [[QXOrderModel alloc] init];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}











- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderModel.orderGoodsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    QXOrderGoodsModel *orderGoodsModel = self.orderModel.orderGoodsList[indexPath.row];
    cell.orderGoodsModel = orderGoodsModel;
    return cell;
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}











#pragma mark - QXOrderDetailFooterViewDelegate
- (void)addGoodsClick
{
    QXGoodsMainViewController *vc = [[QXGoodsMainViewController alloc] init];
    vc.delegate = self;
    vc.type = Type_Select;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)changeState:(BOOL)isFinish
{
    self.orderModel.isFinish = isFinish;
}







#pragma mark - QXGoodsMainViewControllerDelegate
- (void)selectedGoods:(QXGoodsModel*)goodsModel
{
    //选择了商品回调...
    __block QXOrderGoodsModel *orderGoodsModel;
    [self.orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.goodsID isEqualToString:goodsModel.ID])
        {
            orderGoodsModel = obj;
            *stop = YES;
        }
    }];
    
    if (orderGoodsModel)
    {
        orderGoodsModel.buyCount++;
    }
    else
    {
        QXOrderGoodsModel *model = [[QXOrderGoodsModel alloc] init];
        model.goodsID = goodsModel.ID;
        model.orderID = self.orderModel.ID;
        model.adjustCost = goodsModel.costPrice;
        model.adjustPrice = goodsModel.retailPrice;
        model.buyCount = 1;
        [self.orderModel.orderGoodsList addObject:model];
    }
    [self.tableView reloadData];
}













#pragma mark - QXOrderDetailHeadViewDelegate
- (void)onClickSelectCustomer:(QXOrderDetailHeadView*)header
{
    QXCustomerMainViewController *vc = [[QXCustomerMainViewController alloc] init];
    vc.type = Type2_Select;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}








#pragma mark - QXCustomerMainViewControllerDelegate
- (void)vc:(QXCustomerMainViewController*)vc selectedCustomer:(QXCustomerModel*)customerModel
{
    self.orderModel.name = customerModel.name;
    self.orderModel.tel = customerModel.tel;
    self.orderModel.address = customerModel.address;
    QXOrderDetailHeadView *header = (QXOrderDetailHeadView*)self.tableView.tableHeaderView;
    [header refreshCustomerUI];
}











#pragma mark - QXOrderDetailCellDelegate
- (void)cell:(QXOrderDetailCell*)cell onClickMoreButton:(QXOrderGoodsModel*)orderGoodsModel
{
    CGRect cellFrame = [self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:cell]];
    [self removeMoreView];
    
    self.moreView = [[[NSBundle mainBundle] loadNibNamed:@"QXOrderDetailMoreView" owner:self options:nil] lastObject];
    self.moreView.model = orderGoodsModel;
    [self.moreView addTarget:self action:@selector(removeMoreView) forControlEvents:UIControlEventTouchUpInside];
    self.moreView.frame = CGRectMake(self.view.bounds.size.width, cellFrame.origin.y, self.view.bounds.size.width-80, cellFrame.size.height-1);
    [self.tableView addSubview:self.moreView];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.moreView.frame = FRAME_ORIGINX(self.moreView, 80);
    }];
}



@end
