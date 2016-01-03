//
//  QXOrderFooterView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/27.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderFooterView.h"
#import "QXOrderModel.h"
#import "QXOrderGoodsModel.h"
#import "QXGoodsModel.h"

#define EDGE_WIDTH 10

@interface QXOrderFooterView ()
@property (strong, nonatomic, nonnull) UILabel *infoLabel;
@end

@implementation QXOrderFooterView


- (void)onClickRemoveOrder:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(footerViewOnClickRemoveOrder:)])
    {
        [self.delegate footerViewOnClickRemoveOrder:self];
    }
}

- (void)onClickEditOrder:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(footerViewOnClickEditOrder:)])
    {
        [self.delegate footerViewOnClickEditOrder:self];
    }
}



- (void)setOrderModel:(QXOrderModel *)orderModel
{
    if (_orderModel != orderModel)
    {
        _orderModel = orderModel;
    }
    __block NSInteger count = 0;
    __block CGFloat totalPrice = 0.0f;
    __block CGFloat totalCost = 0.0f;
    [_orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QXGoodsModel *model = [[QXGoodsModel alloc] init];
        model.ID = obj.goodsID;
        model = [model fetchModel];
        
        count += obj.buyCount;
        totalPrice += ((obj.adjustPrice)?obj.adjustPrice:model.retailPrice)*obj.buyCount;
        totalCost += ((obj.adjustCost)?obj.adjustCost:model.costPrice)*obj.buyCount;
    }];
    totalPrice += _orderModel.freight;
    _orderModel.price = totalPrice;
    _orderModel.cost = totalCost;
    self.infoLabel.text = STR_FORMAT(@"共%ld件 合计:￥%.2f(含运费:￥%.2f) 赚:￥%.2f ",count,_orderModel.price,_orderModel.freight,_orderModel.profit);
}



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.infoLabel.font = [UIFont systemFontOfSize:14];
        self.infoLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.infoLabel];
        
        
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = RGBA(235, 235, 235, 1);
        [self.contentView addSubview:line];
        
        
        UIButton *deleteOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteOrder.translatesAutoresizingMaskIntoConstraints = NO;
        [deleteOrder addTarget:self action:@selector(onClickRemoveOrder:) forControlEvents:UIControlEventTouchUpInside];
        [deleteOrder setTitle:@"删除订单" forState:UIControlStateNormal];
        deleteOrder.titleLabel.font = [UIFont systemFontOfSize:14];
        [deleteOrder setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        deleteOrder.layer.borderWidth = 1;
        deleteOrder.layer.borderColor = RGBA(235, 235, 235, 1).CGColor;
        deleteOrder.layer.cornerRadius = 5.0f;
        deleteOrder.clipsToBounds = YES;
        [self.contentView addSubview:deleteOrder];
        
        
        UIButton *editOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        editOrder.translatesAutoresizingMaskIntoConstraints = NO;
        [editOrder addTarget:self action:@selector(onClickEditOrder:) forControlEvents:UIControlEventTouchUpInside];
        [editOrder setTitle:@"编辑订单" forState:UIControlStateNormal];
        editOrder.titleLabel.font = [UIFont systemFontOfSize:14];
        [editOrder setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        editOrder.layer.borderWidth = 1;
        editOrder.layer.borderColor = RGBA(235, 235, 235, 1).CGColor;
        editOrder.layer.cornerRadius = 5.0f;
        editOrder.clipsToBounds = YES;
        [self.contentView addSubview:editOrder];

        
        
        UIView *gapView = [[UIView alloc] init];
        gapView.translatesAutoresizingMaskIntoConstraints = NO;
        gapView.backgroundColor = RGBA(225, 225, 225, 1);
        [self.contentView addSubview:gapView];
        
        
        
        /*****************************************************************************************/
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.infoLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:0]];
        [line addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:1]];
        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:deleteOrder
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:line
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [deleteOrder addConstraint:[NSLayoutConstraint constraintWithItem:deleteOrder
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:80]];
        [deleteOrder addConstraint:[NSLayoutConstraint constraintWithItem:deleteOrder
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:30]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:deleteOrder
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-10]];
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:editOrder
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:line
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [editOrder addConstraint:[NSLayoutConstraint constraintWithItem:editOrder
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:80]];
        [editOrder addConstraint:[NSLayoutConstraint constraintWithItem:editOrder
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:30]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:editOrder
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:deleteOrder
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];

        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:gapView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:deleteOrder
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:gapView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:gapView
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:gapView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0]];
        [gapView addConstraint:[NSLayoutConstraint constraintWithItem:gapView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1
                                                             constant:15]];
        
    }
    return self;
}

@end
