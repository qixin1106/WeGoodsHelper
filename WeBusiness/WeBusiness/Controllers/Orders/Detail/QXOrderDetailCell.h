//
//  QXOrderDetailCell.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderMainCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol QXOrderDetailCellDelegate;
@interface QXOrderDetailCell : QXOrderMainCell
@property (weak, nonatomic, nullable) id<QXOrderDetailCellDelegate> delegate;
@end

@protocol QXOrderDetailCellDelegate <NSObject>
- (void)cell:(QXOrderDetailCell*)cell onClickMoreButton:(QXOrderGoodsModel*)orderGoodsModel;
@end

NS_ASSUME_NONNULL_END