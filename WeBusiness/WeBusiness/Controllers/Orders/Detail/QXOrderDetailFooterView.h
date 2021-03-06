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
@end

@protocol QXOrderDetailFooterViewDelegate <NSObject>
- (void)addGoodsClick;
- (void)changeState:(BOOL)isFinish;//切换交易状态
- (void)changeFreight:(CGFloat)freight;//改变运费
- (void)changeDiscount:(CGFloat)discount;//改变折扣
- (void)changeDate:(NSTimeInterval)date;//改变下单时间
@end

NS_ASSUME_NONNULL_END