//
//  QXOrderMainViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, OrderMainType) {
    OrderMainType_Display=0,
    OrderMainType_Select=1
};
@class QXOrderModel;
@protocol QXOrderMainViewControllerDelegate;
@interface QXOrderMainViewController : QXBaseTableViewController
@property (weak, nonatomic, nullable) id<QXOrderMainViewControllerDelegate> delegate;
@property (assign, nonatomic) OrderMainType type;
@end


@protocol QXOrderMainViewControllerDelegate <NSObject>
- (void)vc:(QXOrderMainViewController*)vc selectedOrder:(QXOrderModel*)orderModel;
@end
NS_ASSUME_NONNULL_END