//
//  QXOrderMainCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/27.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderMainCell.h"
#import "QXOrderGoodsModel.h"
#import "NSDate+Utils.h"
#import "UIImage+Utils.h"
#import "QXGoodsModel.h"

@interface QXOrderMainCell ()
@property (strong, nonatomic, nonnull) UIImageView *goodsImageView;
@property (strong, nonatomic, nonnull) UILabel *goodsNameLabel;
@property (strong, nonatomic, nonnull) UILabel *priceLabel;
@property (strong, nonatomic, nonnull) UILabel *countLabel;
@end

@implementation QXOrderMainCell


- (void)setOrderGoodsModel:(QXOrderGoodsModel *)orderGoodsModel
{
    if (_orderGoodsModel != orderGoodsModel)
    {
        _orderGoodsModel = orderGoodsModel;
    }
    QXGoodsModel *model = [[QXGoodsModel alloc] init];
    model.ID = _orderGoodsModel.goodsID;
    model = [model fetchModel];
    
    NSArray *imgs = [model.picID componentsSeparatedByString:@";"];
    NSString *picID = [imgs firstObject];
    self.goodsImageView.image = [UIImage imageWithPicID:picID isThumb:YES];
    self.goodsNameLabel.text = model.name;
    self.priceLabel.text = STR_FORMAT(@"￥%.2f",(_orderGoodsModel.adjustPrice)?_orderGoodsModel.adjustPrice:model.retailPrice);
    self.countLabel.text = STR_FORMAT(@"x%ld",_orderGoodsModel.buyCount);
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBA(250, 250, 250, 1);
        
        self.goodsImageView = [[UIImageView alloc] init];
        self.goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.goodsImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.goodsImageView];
        
        
        self.goodsNameLabel = [[UILabel alloc] init];
        self.goodsNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.goodsNameLabel.font = [UIFont systemFontOfSize:14];
        self.goodsNameLabel.numberOfLines = 2;
        [self.contentView addSubview:self.goodsNameLabel];
        
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.priceLabel];
        
        
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.countLabel.font = [UIFont systemFontOfSize:12];
        self.countLabel.textColor = RGBA(128, 128, 128, 1);
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.countLabel];
        
        
        /************************************************************************************/
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:10]];
        [self.goodsImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:60]];
        [self.goodsImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:60]];
        
        
        
        

        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsNameLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsNameLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-100]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsNameLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsNameLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.priceLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:10]];


        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-10]];
        [self.priceLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:100]];


        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.priceLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-100]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.goodsNameLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:10]];
    }
    return self;
}















@end
