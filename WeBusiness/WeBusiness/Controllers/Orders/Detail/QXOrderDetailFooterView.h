//
//  QXOrderDetailFooterView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class QXOrderModel;
@protocol QXOrderDetailFooterViewDelegate;
@interface QXOrderDetailFooterView : UIView
@property (weak, nonatomic, nullable) id<QXOrderDetailFooterViewDelegate>delegate;
@property (strong, nonatomic, nullable) QXOrderModel *orderModel;
- (void)assignModel;
@end

@protocol QXOrderDetailFooterViewDelegate <NSObject>
- (void)addGoodsClick;
- (void)changeState:(BOOL)isFinish;
@end

NS_ASSUME_NONNULL_END