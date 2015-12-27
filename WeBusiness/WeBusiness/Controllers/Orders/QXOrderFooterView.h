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
@interface QXOrderFooterView : UITableViewHeaderFooterView
@property (strong, nonatomic, nullable) QXOrderModel *orderModel;
@property (strong, nonatomic, nullable) NSIndexPath *indexPath;
@end
NS_ASSUME_NONNULL_END