//
//  QXOrderDetailFooterView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailFooterView.h"
#import "QXOrderModel.h"


@interface QXOrderDetailFooterView ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *stateSegmented;
@end

@implementation QXOrderDetailFooterView




- (void)setOrderModel:(QXOrderModel *)orderModel
{
    if (_orderModel!=orderModel)
    {
        _orderModel=orderModel;
        _stateSegmented.selectedSegmentIndex = _orderModel.isFinish;
    }
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeState:)])
    {
        [self.delegate changeState:sender.selectedSegmentIndex];
    }
}

@end
