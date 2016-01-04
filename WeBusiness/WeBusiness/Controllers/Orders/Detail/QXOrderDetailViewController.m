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
#import "QXScanCodeViewController.h"

static NSString *identifier = @"QXOrderDetailCell";
static NSString *identifierHeader = @"QXOrderHeaderView";
static NSString *identifierFooter = @"QXOrderFooterView";


@interface QXOrderDetailViewController ()
<QXOrderDetailFooterViewDelegate,
QXGoodsMainViewControllerDelegate,
QXOrderDetailHeadViewDelegate,
QXCustomerMainViewControllerDelegate,
QXOrderDetailCellDelegate,
QXOrderDetailMoreViewDelegate,
QXScanCodeViewControllerDelegate>
@property (strong, nonatomic) QXOrderModel *orderModel;
@property (strong, nonatomic) QXOrderDetailMoreView *moreView;
@end

@implementation QXOrderDetailViewController






- (void)checkPrice
{
    __block CGFloat totalCost=0,totalPrice=0;
    [self.orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //TODO:计算成本
        totalCost += (obj.adjustCost * obj.buyCount);
        //TODO:计算总价
        totalPrice += (obj.adjustPrice * obj.buyCount);
    }];
    
    //加运费
    totalPrice += self.orderModel.freight;
    totalPrice -= self.orderModel.discount;
    self.orderModel.cost = totalCost;
    self.orderModel.price = totalPrice;
    //TODO:计算利润
    self.orderModel.profit = self.orderModel.price - self.orderModel.cost - self.orderModel.freight;
    
    //刷新footer
    QXOrderDetailFooterView *footer = (QXOrderDetailFooterView*)self.tableView.tableFooterView;
    footer.orderModel = self.orderModel;
}





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
    //新增
    if (self.templateType==TemplateType_Add)
    {
        if (VALID_STRING(self.orderModel.name) &&
            VALID_STRING(self.orderModel.tel) &&
            VALID_STRING(self.orderModel.address) &&
            self.orderModel.orderGoodsList.count)
        {
            QXOrderDetailHeadView *header = (QXOrderDetailHeadView*)self.tableView.tableHeaderView;
            [header assignModel];
            
            [self.orderModel store];
            [self.orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj store];
            }];
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetail:onSaveModel:)])
            {
                [self.delegate orderDetail:self onSaveModel:self.orderModel];
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            ALERT(@"姓名,电话,地址,商品必填", nil);
        }
        return;
    }
    
    //编辑
    if (self.templateType==TemplateType_Edit)
    {
        if (VALID_STRING(self.orderModel.name) &&
            VALID_STRING(self.orderModel.tel) &&
            VALID_STRING(self.orderModel.address) &&
            self.orderModel.orderGoodsList.count)
        {
            QXOrderDetailHeadView *header = (QXOrderDetailHeadView*)self.tableView.tableHeaderView;
            [header assignModel];
            
            [self.orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj refresh];
            }];
            [self.orderModel refresh];
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetail:onSaveModel:)])
            {
                [self.delegate orderDetail:self onSaveModel:self.orderModel];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            ALERT(@"姓名,电话,地址,商品必填", nil);
        }
        return;
    }
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
    [self checkPrice];
    
}



- (void)loadData
{
    if (self.templateType==TemplateType_Edit)
    {
        QXOrderModel *model = [[QXOrderModel alloc] init];
        model.ID = self.orderID;
        self.orderModel = [model fetchModel];
        QXOrderGoodsModel *goodsModel = [[QXOrderGoodsModel alloc] init];
        NSArray *goodsList = [goodsModel fetchWithOrderID:model.ID];
        self.orderModel.orderGoodsList = [goodsList mutableCopy];
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







#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeMoreView];
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        QXOrderGoodsModel *model = self.orderModel.orderGoodsList[indexPath.row];
        [self.orderModel.orderGoodsList removeObject:model];
        [model remove];
        
        [self checkPrice];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}









- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeMoreView];
    [self.tableView endEditing:NO];
}





#pragma mark - QXOrderDetailFooterViewDelegate
//点击增加商品
- (void)addGoodsClick
{
    QXGoodsMainViewController *vc = [[QXGoodsMainViewController alloc] init];
    vc.delegate = self;
    vc.type = Type_Select;
    [self.navigationController pushViewController:vc animated:YES];
}

//改变交易状态回调
- (void)changeState:(BOOL)isFinish
{
    self.orderModel.isFinish = isFinish;
}

//改变运费回调
- (void)changeFreight:(CGFloat)freight
{
    [self checkPrice];
}

//改变折扣回调
- (void)changeDiscount:(CGFloat)discount
{
    [self checkPrice];
}

//改变下单时间
- (void)changeDate:(NSTimeInterval)date
{
    //[self checkPrice];
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
    
    if (orderGoodsModel)//已加入该商品
    {
        orderGoodsModel.buyCount++;
    }
    else
    {
        orderGoodsModel = [[QXOrderGoodsModel alloc] init];
        orderGoodsModel.goodsID = goodsModel.ID;
        orderGoodsModel.orderID = self.orderModel.ID;
        orderGoodsModel.adjustCost = goodsModel.costPrice;
        orderGoodsModel.adjustPrice = goodsModel.retailPrice;
        orderGoodsModel.buyCount = 1;
        [self.orderModel.orderGoodsList addObject:orderGoodsModel];
    }
    
    //计算
    [self checkPrice];
    
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

- (void)onScanButton:(QXOrderDetailHeadView*)header
{
    QXScanCodeViewController *vc = [[QXScanCodeViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:NULL];
}






#pragma mark - QXCustomerMainViewControllerDelegate
- (void)vc:(QXCustomerMainViewController*)vc selectedCustomer:(QXCustomerModel*)customerModel
{
    self.orderModel.name = customerModel.name;
    self.orderModel.tel = customerModel.tel;
    self.orderModel.address = customerModel.address;
    QXOrderDetailHeadView *header = (QXOrderDetailHeadView*)self.tableView.tableHeaderView;
    header.orderModel = self.orderModel;
}











#pragma mark - QXOrderDetailCellDelegate
- (void)cell:(QXOrderDetailCell*)cell onClickMoreButton:(QXOrderGoodsModel*)orderGoodsModel
{
    CGRect cellFrame = [self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:cell]];
    [self removeMoreView];
    
    self.moreView = [[[NSBundle mainBundle] loadNibNamed:@"QXOrderDetailMoreView" owner:self options:nil] lastObject];
    self.moreView.delegate = self;
    self.moreView.indexPath = cell.indexPath;
    self.moreView.model = orderGoodsModel;
    [self.moreView addTarget:self action:@selector(removeMoreView) forControlEvents:UIControlEventTouchUpInside];
    self.moreView.frame = CGRectMake(self.view.bounds.size.width, cellFrame.origin.y, self.view.bounds.size.width-80, cellFrame.size.height-1);
    [self.tableView addSubview:self.moreView];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.moreView.frame = FRAME_ORIGINX(self.moreView, 80);
    }];
}








#pragma mark - QXOrderDetailMoreViewDelegate
- (void)changeValueCallback:(QXOrderDetailMoreView*)moreView
{
    [self checkPrice];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[moreView.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}











#pragma mark - QXScanCodeViewControllerDelegate
- (void)scanCodeFinish:(QXScanCodeViewController*)vc code:(NSString*)code
{
    [vc dismissViewControllerAnimated:YES completion:NULL];
    self.orderModel.cn = code;
    
    QXOrderDetailHeadView *header = (QXOrderDetailHeadView*)self.tableView.tableHeaderView;
    header.orderModel = self.orderModel;
}





@end
