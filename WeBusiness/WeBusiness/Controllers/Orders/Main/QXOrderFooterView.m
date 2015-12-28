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

- (void)setOrderModel:(QXOrderModel *)orderModel
{
    if (_orderModel != orderModel)
    {
        _orderModel = orderModel;
        
        __block NSInteger count = 0;
        __block CGFloat totalPrice = 0.0f;
        [_orderModel.orderGoodsList enumerateObjectsUsingBlock:^(QXOrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QXGoodsModel *model = [[QXGoodsModel alloc] init];
            model.ID = obj.goodsID;
            model = [model fetchModel];
            
            count += obj.buyCount;
            totalPrice += ((obj.adjustPrice)?obj.adjustPrice:model.retailPrice)*obj.buyCount;
        }];
        totalPrice += _orderModel.freight;
        self.infoLabel.text = STR_FORMAT(@"共%ld件商品 合计:￥%.2f (含运费:￥%.2f)",count,totalPrice,_orderModel.freight);
    }
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
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
        
        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:gapView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.infoLabel
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
