//
//  QXOrderDetailCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailCell.h"

#define MARGIN_SPACE 0

@implementation QXOrderDetailCell



- (void)onClickMore:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:onClickMoreButton:)])
    {
        [self.delegate cell:self onClickMoreButton:self.orderGoodsModel];
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moreButton.translatesAutoresizingMaskIntoConstraints = NO;
        [moreButton addTarget:self action:@selector(onClickMore:) forControlEvents:UIControlEventTouchUpInside];
        [moreButton setImage:[UIImage imageNamed:@"search_item_shop_info_button"] forState:UIControlStateNormal];
        [self.contentView addSubview:moreButton];
        
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moreButton
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:MARGIN_SPACE]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moreButton
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:MARGIN_SPACE]];
        [moreButton addConstraint:[NSLayoutConstraint constraintWithItem:moreButton
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:48]];
        [moreButton addConstraint:[NSLayoutConstraint constraintWithItem:moreButton
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:30]];
    }
    return self;
}
@end
