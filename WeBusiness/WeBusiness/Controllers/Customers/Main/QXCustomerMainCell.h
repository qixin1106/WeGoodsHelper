//
//  QXCustomerMainCell.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class QXCustomerModel;
@interface QXCustomerMainCell : UITableViewCell
@property (strong, nonatomic, nullable) QXCustomerModel *customerModel;
@end
NS_ASSUME_NONNULL_END