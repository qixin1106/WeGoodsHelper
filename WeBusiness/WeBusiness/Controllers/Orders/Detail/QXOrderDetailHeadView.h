//
//  QXOrderDetailHeadView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QXOrderModel;
@protocol QXOrderDetailHeadViewDelegate;
@interface QXOrderDetailHeadView : UIView
@property (weak, nonatomic) id<QXOrderDetailHeadViewDelegate>delegate;
@property (strong, nonatomic) QXOrderModel *orderModel;
- (void)assignModel;
- (void)refreshCustomerUI;
@end

@protocol QXOrderDetailHeadViewDelegate <NSObject>
- (void)onClickSelectCustomer:(QXOrderDetailHeadView*)header;
@end