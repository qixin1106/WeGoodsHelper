//
//  QXGoodsMainCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsMainCell.h"
#import "QXGoodsModel.h"
#import "QXGoodsModel+Utils.h"
#import "UIImage+Utils.h"


#define MARGIN_SPACE 10
#define GOODS_IMAGE_WIDTH 125

@interface QXGoodsMainCell ()
@property (strong, nonatomic) UIImageView *goodsImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *retailLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) UIButton *moreButton;
@end

@implementation QXGoodsMainCell


- (void)onClickMore:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClickMoreCallBack:)])
    {
        [self.delegate onClickMoreCallBack:self];
    }
}




- (void)setGoodsModel:(QXGoodsModel *)goodsModel
{
    if (_goodsModel!=goodsModel)
    {
        _goodsModel = goodsModel;
        self.nameLabel.text = _goodsModel.name;
        self.retailLabel.text = STR_FORMAT(@"￥%.2f",_goodsModel.retailPrice);
        self.countLabel.text = STR_FORMAT(@"%ld件",_goodsModel.count);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                NSArray *imgs = [_goodsModel.picID componentsSeparatedByString:@";"];
                NSString *picID = [imgs firstObject];
                UIImage *image = [UIImage imageWithPicID:picID isThumb:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.goodsImageView.image = (image)?image:[UIImage imageNamed:@"mb"];
                });
            }
        });
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        /****************************************************************************************/
        /*                                控件初始化                                              */
        /****************************************************************************************/
        //商品图片
        self.goodsImageView = [[UIImageView alloc] init];
        self.goodsImageView.clipsToBounds = YES;
        self.goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.goodsImageView.image = [UIImage imageNamed:@"test"];
        self.goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.goodsImageView];

        
        //商品名字
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.numberOfLines = 2;
        [self.contentView addSubview:self.nameLabel];

        
        //商品零售价格
        self.retailLabel = [[UILabel alloc] init];
        self.retailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.retailLabel.font = [UIFont systemFontOfSize:17];
        self.retailLabel.textColor = RGBA(255, 128, 0, 1);
        self.retailLabel.numberOfLines = 1;
        [self.contentView addSubview:self.retailLabel];
        
        
        
        //商品数量
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.countLabel.font = [UIFont systemFontOfSize:13];
        self.countLabel.textColor = RGBA(156, 156, 156, 1);
        self.countLabel.numberOfLines = 1;
        [self.contentView addSubview:self.countLabel];
        
        
        //更多操作按钮
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.moreButton addTarget:self action:@selector(onClickMore:) forControlEvents:UIControlEventTouchUpInside];
        [self.moreButton setImage:[UIImage imageNamed:@"search_item_shop_info_button"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.moreButton];
        
        
        //分割线
        _line = [[UIView alloc] init];
        _line.translatesAutoresizingMaskIntoConstraints = NO;
        _line.backgroundColor = CELL_SEPARATOR_COLOR;
        [self.contentView addSubview:_line];
        
        
        
        /****************************************************************************************/
        /*                                AutoLayout                                            */
        /****************************************************************************************/
        //图片
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:0]];
        [self.goodsImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:GOODS_IMAGE_WIDTH]];
        [self.goodsImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:GOODS_IMAGE_WIDTH]];

        
        
        //名字
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:MARGIN_SPACE]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:MARGIN_SPACE]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-MARGIN_SPACE]];
        [self.nameLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:35]];

        //单价
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.retailLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-MARGIN_SPACE]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.retailLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:MARGIN_SPACE]];
        [self.retailLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.retailLabel
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:20]];

        
        //数量
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.retailLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-MARGIN_SPACE]];
        [self.countLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1
                                                                      constant:20]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.retailLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:MARGIN_SPACE]];
        
        
        
        //更多
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.moreButton
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-MARGIN_SPACE]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.moreButton
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.countLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];
        [self.moreButton addConstraint:[NSLayoutConstraint constraintWithItem:self.moreButton
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:48]];
        [self.moreButton addConstraint:[NSLayoutConstraint constraintWithItem:self.moreButton
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:30]];



        
        
        //分割线
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-ONE_PIXEL_VALUE]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.goodsImageView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:0]];
        [_line addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1
                                                               constant:ONE_PIXEL_VALUE]];
    }
    return self;
}






@end
