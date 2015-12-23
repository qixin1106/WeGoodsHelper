//
//  QXGoodsDetailImageItemCell.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QXGoodsDetailImageItemCellDelegate;
@interface QXGoodsDetailImageItemCell : UICollectionViewCell
@property (weak, nonatomic) id<QXGoodsDetailImageItemCellDelegate>delegate;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@protocol QXGoodsDetailImageItemCellDelegate <NSObject>
- (void)longPressCallBack:(QXGoodsDetailImageItemCell*)cell;
@end