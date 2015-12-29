//
//  QXCustomerMainViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, Type2) {
    Type2_Display=0,
    Type2_Select=1
};
@class QXCustomerModel;
@protocol QXCustomerMainViewControllerDelegate;
@interface QXCustomerMainViewController : QXBaseTableViewController
@property (weak, nonatomic) id<QXCustomerMainViewControllerDelegate>delegate;
@property (assign, nonatomic) Type2 type;
@end


@protocol QXCustomerMainViewControllerDelegate <NSObject>
- (void)vc:(QXCustomerMainViewController*)vc selectedCustomer:(QXCustomerModel*)customerModel;
@end