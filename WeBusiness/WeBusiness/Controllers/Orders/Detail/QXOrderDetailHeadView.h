//
//  QXOrderDetailHeadView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QXOrderModel;
@interface QXOrderDetailHeadView : UIView
@property (strong, nonatomic) QXOrderModel *orderModel;
- (void)assignModel;
@end
