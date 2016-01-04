//
//  QXOrderDetailFooterView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailFooterView.h"
#import "QXOrderModel.h"
#import "NSDate+Utils.h"

@interface QXOrderDetailFooterView ()
@property (weak, nonatomic) IBOutlet UITextField *freightTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *orderDateTimePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *stateSegmented;
@end

@implementation QXOrderDetailFooterView



- (void)setOrderModel:(QXOrderModel *)orderModel
{
    if (_orderModel!=orderModel)
    {
        _orderModel=orderModel;
    }
    _stateSegmented.selectedSegmentIndex = _orderModel.isFinish;
    _freightTextField.text = STR_FORMAT(@"%.2f",_orderModel.freight);
    _discountTextField.text = STR_FORMAT(@"%.2f",_orderModel.discount);
    _costLabel.text = STR_FORMAT(@"%.2f",_orderModel.cost);
    _totalPriceLabel.text = STR_FORMAT(@"%.2f",_orderModel.price);
    _profitLabel.text = STR_FORMAT(@"%.2f",_orderModel.profit);
    _orderDateTimePicker.date = (_orderModel.buyerOrderTime)?[NSDate dateWithTimeIntervalSinceNow:_orderModel.buyerOrderTime]:[NSDate date];
}



- (IBAction)addGoodsButton:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsClick)])
    {
        [self.delegate addGoodsClick];
    }
}


- (IBAction)changeOrderState:(UISegmentedControl *)sender
{
    self.orderModel.isFinish = sender.selectedSegmentIndex;
    sender.tintColor = (sender.selectedSegmentIndex)?RGBA(0, 128, 0, 1):[UIColor redColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeState:)])
    {
        [self.delegate changeState:sender.selectedSegmentIndex];
    }
}

- (IBAction)changeOrderFreight:(UITextField *)sender
{
    self.orderModel.freight = [sender.text floatValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeFreight:)])
    {
        [self.delegate changeFreight:self.orderModel.freight];
    }
}


- (IBAction)changeOrderDiscount:(UITextField *)sender
{
    self.orderModel.discount = [sender.text floatValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeDiscount:)])
    {
        [self.delegate changeDiscount:self.orderModel.discount];
    }
}

- (IBAction)changeOrderDate:(UIDatePicker *)sender
{
    self.orderModel.buyerOrderTime = [sender.date timeIntervalSinceReferenceDate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeDate:)])
    {
        [self.delegate changeDate:self.orderModel.buyerOrderTime];
    }
}

- (IBAction)timeToNow:(UIButton *)sender
{
    [self.orderDateTimePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:CFAbsoluteTimeGetCurrent()] animated:YES];
    self.orderModel.buyerOrderTime = CFAbsoluteTimeGetCurrent();
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeDate:)])
    {
        [self.delegate changeDate:self.orderModel.buyerOrderTime];
    }
}





@end
