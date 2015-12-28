//
//  QXOrderDetailFooterView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailFooterView.h"
#import "QXOrderModel.h"
@implementation QXOrderDetailFooterView

- (IBAction)addGoodsButton:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsClick)])
    {
        [self.delegate addGoodsClick];
    }
}

- (IBAction)isFinishSwicth:(UISwitch *)sender
{
    self.orderModel.isFinish = sender.on;
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeState:)])
    {
        [self.delegate changeState:sender.on];
    }
}


@end
