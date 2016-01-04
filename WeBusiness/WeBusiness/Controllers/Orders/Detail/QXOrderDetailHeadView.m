//
//  QXOrderDetailHeadView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailHeadView.h"
#import "QXOrderModel.h"
#import "QXCustomerMainViewController.h"

@interface QXOrderDetailHeadView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UITextField *cnTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@end

@implementation QXOrderDetailHeadView

- (IBAction)onScanClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onScanButton:)])
    {
        [self.delegate onScanButton:self];
    }
}

- (IBAction)onAddCustomer:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClickSelectCustomer:)])
    {
        [self.delegate onClickSelectCustomer:self];
    }
}

- (void)assignModel
{
    self.orderModel.name = self.nameTextField.text;
    self.orderModel.tel = self.telTextField.text;
    self.orderModel.address = self.addressTextView.text;
    self.orderModel.cn = self.cnTextField.text;
    self.orderModel.remark = self.remarkTextView.text;
}





- (void)setOrderModel:(QXOrderModel *)orderModel
{
    if (_orderModel!=orderModel)
    {
        _orderModel=orderModel;
    }
    self.nameTextField.text = self.orderModel.name;
    self.telTextField.text = self.orderModel.tel;
    self.addressTextView.text = self.orderModel.address;
    self.cnTextField.text = self.orderModel.cn;
    self.remarkTextView.text = self.orderModel.remark;
}


- (void)refreshCustomerUI
{
    self.nameTextField.text = self.orderModel.name;
    self.telTextField.text = self.orderModel.tel;
    self.addressTextView.text = self.orderModel.address;
    self.cnTextField.text = self.orderModel.cn;
    self.remarkTextView.text = self.orderModel.remark;
}


@end
