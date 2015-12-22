//
//  QXGoodsDetailGoodsImageCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsDetailGoodsImageCell.h"
#import "QXGoodsModel.h"


@interface QXGoodsDetailGoodsImageCell ()
@property (strong, nonatomic) UIImageView *goodsImageView;
@end

@implementation QXGoodsDetailGoodsImageCell


- (void)setPicID:(NSString *)picID
{
    if (_picID!=picID)
    {
        _picID=picID;
        NSString *imgPath = [[QXFileUtil assetsPath] stringByAppendingPathComponent:picID];
        self.goodsImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgPath options:NSDataReadingMappedIfSafe error:nil]];
    }
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.goodsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.goodsImageView];
        
        
        
        
        
        
        /****************************************************************************************/
        /*                                AutoLayout                                            */
        /****************************************************************************************/
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:0]];


    }
    return self;
}

@end
