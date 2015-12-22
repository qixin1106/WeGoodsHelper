//
//  QXCustomerModel.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *kCustomRefresh = @"kCustomRefresh";

@interface QXCustomerModel : QXBaseModel
@property (copy, nonatomic, nullable) NSString *name;
@property (copy, nonatomic, nullable) NSString *tel;
@property (copy, nonatomic, nullable) NSString *address;
@property (copy, nonatomic, nullable) NSString *wechatID;
@property (assign, nonatomic) NSInteger type;
@property (copy, nonatomic, nullable) NSString *picID;

- (void)store;//insert data
- (void)refresh;//update data
- (void)remove;//delete data
- (NSArray*)fetchAll;//select all data
- (QXCustomerModel*)fetchModel;//select model with uid
@end
NS_ASSUME_NONNULL_END