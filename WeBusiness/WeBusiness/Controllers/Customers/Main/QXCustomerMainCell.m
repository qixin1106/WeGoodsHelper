//
//  QXCustomerMainCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerMainCell.h"
#import "QXCustomerModel.h"

#define EDGE_WIDTH 10
#define LABEL_HEIGHT 20
@interface QXCustomerMainCell ()
@property (strong, nonatomic, nonnull) UILabel *nameLabel;
@property (strong, nonatomic, nonnull) UILabel *addressLabel;
@property (strong, nonatomic, nonnull) UILabel *telLabel;
@end

@implementation QXCustomerMainCell

- (void)setCustomerModel:(QXCustomerModel *)customerModel
{
    if (_customerModel != customerModel)
    {
        _customerModel = customerModel;
        
        self.nameLabel.text = _customerModel.name;
        self.telLabel.text = _customerModel.tel;
        self.addressLabel.text = _customerModel.address;
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        self.nameLabel.textColor = RGBA(55, 55, 55, 1);
        [self.contentView addSubview:self.nameLabel];
        
        self.telLabel = [[UILabel alloc] init];
        self.telLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.telLabel.font = [UIFont systemFontOfSize:17];
        self.telLabel.textColor = RGBA(55, 55, 55, 1);
        [self.contentView addSubview:self.telLabel];

        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.addressLabel.font = [UIFont systemFontOfSize:12];
        self.addressLabel.textColor = RGBA(128, 128, 128, 1);
        self.addressLabel.numberOfLines = 0;
        [self.contentView addSubview:self.addressLabel];
        
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
        [self.nameLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:LABEL_HEIGHT]];
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.telLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.telLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];
        [self.telLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.telLabel
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                       constant:LABEL_HEIGHT]];
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addressLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:EDGE_WIDTH]];
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
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.addressLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-EDGE_WIDTH]];


    }
    return self;
}

@end
