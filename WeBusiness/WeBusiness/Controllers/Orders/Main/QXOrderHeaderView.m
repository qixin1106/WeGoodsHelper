//
//  QXOrderHeaderView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/27.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderHeaderView.h"
#import "QXOrderModel.h"
#import "NSDate+Utils.h"

#define EDGE_WIDTH 10

@interface QXOrderHeaderView ()
@property (strong, nonatomic, nonnull) UILabel *nameLabel;
@property (strong, nonatomic, nonnull) UILabel *addressLabel;
@property (strong, nonatomic, nonnull) UILabel *telLabel;
@property (strong, nonatomic, nonnull) UILabel *orderTimeLabel;
@property (strong, nonatomic, nonnull) UILabel *stateLabel;
@end

@implementation QXOrderHeaderView



- (void)setOrderModel:(QXOrderModel *)orderModel
{
    if (_orderModel != orderModel)
    {
        _orderModel = orderModel;
        
        self.nameLabel.text = _orderModel.name;
        self.addressLabel.text = _orderModel.address;
        self.telLabel.text = _orderModel.tel;
        self.orderTimeLabel.text = [NSDate dateToString:_orderModel.buyerOrderTime];
        self.stateLabel.text = (_orderModel.isFinish)?@"交易完成":@"交易中";
        self.stateLabel.textColor = (_orderModel.isFinish)?RGBA(200, 200, 200, 1):RGBA(255, 0, 0, 1);
    }
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.nameLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:self.nameLabel];
        
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.addressLabel.font = [UIFont systemFontOfSize:14];
        self.addressLabel.textColor = RGBA(128, 128, 128, 1);
        self.addressLabel.numberOfLines = 0;
        [self.contentView addSubview:self.addressLabel];
        
        
        self.telLabel = [[UILabel alloc] init];
        self.telLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.telLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.telLabel];
        
        
        self.orderTimeLabel = [[UILabel alloc] init];
        self.orderTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.orderTimeLabel.font = [UIFont systemFontOfSize:12];
        self.orderTimeLabel.textColor = RGBA(128, 128, 128, 1);
        [self.contentView addSubview:self.orderTimeLabel];
        
        
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.stateLabel.font = [UIFont systemFontOfSize:14];
        self.stateLabel.textColor = RGBA(255, 0, 0, 1);
        [self.contentView addSubview:self.stateLabel];
        
        
        /***************************************************************************************/
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.telLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.telLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];
        
        
        /*
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stateLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.telLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];
         */
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stateLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.stateLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addressLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addressLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addressLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.orderTimeLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.orderTimeLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.addressLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.orderTimeLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.orderTimeLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
    }
    return self;
}

@end
