//
//  QXCustomerModel.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface QXCustomerModel : QXBaseModel
@property (assign, nonatomic) NSInteger uid;
@property (copy, nonatomic, nullable) NSString *name;
@property (copy, nonatomic, nullable) NSString *tel;
@property (copy, nonatomic, nullable) NSString *address;
@property (copy, nonatomic, nullable) NSString *wechatID;
@property (assign, nonatomic) NSInteger type;
@property (copy, nonatomic, nullable) NSString *picID;

- (void)store;//insert data
- (NSArray*)fetchAll;//select all data
- (QXCustomerModel*)fetchModel;//select model with uid
@end
NS_ASSUME_NONNULL_END