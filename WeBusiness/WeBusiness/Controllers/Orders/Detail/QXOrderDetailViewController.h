//
//  QXOrderDetailViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/28.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"
@class QXOrderModel;
typedef NS_ENUM(NSUInteger, TemplateType) {
    TemplateType_Edit=0,//default
    TemplateType_Add=1,
};
@protocol QXOrderDetailViewControllerDelegate;
@interface QXOrderDetailViewController : QXBaseTableViewController
@property (weak, nonatomic) id<QXOrderDetailViewControllerDelegate>delegate;
@property (copy, nonatomic) NSString *orderID;
@property (assign, nonatomic) TemplateType templateType;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@protocol QXOrderDetailViewControllerDelegate <NSObject>
- (void)orderDetail:(QXOrderDetailViewController*)vc onSaveModel:(QXOrderModel*)orderModel;
@end