//
//  QXGoodsDetailTextCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsDetailTextCell.h"

@interface QXGoodsDetailTextCell ()
@end

@implementation QXGoodsDetailTextCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.titleLabel];
        
        
        NSInteger constant = 10;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:constant]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-constant]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:constant]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-constant]];
        [self.titleLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:24]];
    }
    return self;
}
@end
