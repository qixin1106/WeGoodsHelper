//
//  QXGoodsDetailTableViewHeaderView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QXGoodsDetailImageItemCell;
@protocol QXGoodsDetailTableViewHeaderViewDelegate;
@interface QXGoodsDetailTableViewHeaderView : UIView
@property (weak, nonatomic) id<QXGoodsDetailTableViewHeaderViewDelegate> delegate;
@property (copy, nonatomic) NSString *picID;
@end

@protocol QXGoodsDetailTableViewHeaderViewDelegate <NSObject>
- (void)headerView:(QXGoodsDetailTableViewHeaderView*)headerView isAddImage:(BOOL)isAdd picID:(NSString*)picID;
- (void)headerView:(QXGoodsDetailTableViewHeaderView*)headerView longPressPicID:(NSString*)picID longPressCell:(QXGoodsDetailImageItemCell*)cell;
@end