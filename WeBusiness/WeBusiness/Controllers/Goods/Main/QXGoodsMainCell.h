//
//  QXGoodsMainCell.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class QXGoodsModel;
@protocol QXGoodsMainCellDelegate;
@interface QXGoodsMainCell : UITableViewCell
@property (weak, nonatomic) id<QXGoodsMainCellDelegate> delegate;
@property (strong, nonatomic, nullable) QXGoodsModel *goodsModel;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic, readonly) UIView *line;
@end

@protocol QXGoodsMainCellDelegate <NSObject>
- (void)onClickMoreCallBack:(QXGoodsMainCell*)cell;
@end
NS_ASSUME_NONNULL_END