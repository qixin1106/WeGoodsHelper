//
//  QXCustomerDetailViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"


@class QXCustomerModel;
typedef NS_ENUM(NSUInteger, TemplateType) {
    TemplateType_Display=0,//default
    TemplateType_Add=1,
};
typedef void(^SaveCustomerBlock)(QXCustomerModel *customerModel);
@interface QXCustomerDetailViewController : QXBaseTableViewController
@property (copy, nonatomic) NSString *uid;
@property (assign, nonatomic) TemplateType templateType;
@property (copy, nonatomic) SaveCustomerBlock saveCustomerBlock;
@end
