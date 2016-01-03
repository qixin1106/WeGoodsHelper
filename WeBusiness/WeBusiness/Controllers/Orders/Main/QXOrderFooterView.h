//
//  QXOrderFooterView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/27.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class QXOrderModel;

@protocol QXOrderFooterViewDelegate;
@interface QXOrderFooterView : UITableViewHeaderFooterView
@property (weak, nonatomic, nullable) id<QXOrderFooterViewDelegate> delegate;
@property (strong, nonatomic, nullable) QXOrderModel *orderModel;
@property (strong, nonatomic, nullable) NSIndexPath *indexPath;
@end


@protocol QXOrderFooterViewDelegate <NSObject>
- (void)footerViewOnClickRemoveOrder:(QXOrderFooterView*)footer;
- (void)footerViewOnClickEditOrder:(QXOrderFooterView*)footer;
@end
NS_ASSUME_NONNULL_END