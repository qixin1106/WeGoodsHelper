//
//  QXOrderModel.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/24.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface QXOrderModel : QXBaseModel
@property (copy, nonatomic, nullable) NSString *name;
@property (copy, nonatomic, nullable) NSString *tel;
@property (copy, nonatomic, nullable) NSString *address;
@property (copy, nonatomic, nullable) NSString *cn;//快递单号
@property (copy, nonatomic, nullable) NSString *remark;//备注
@property (assign, nonatomic) CFTimeInterval buyerOrderTime;//客户下单时间
@property (assign, nonatomic) CGFloat freight;//运费
@property (assign, nonatomic) CGFloat price;//总价
@property (assign, nonatomic) CGFloat cost;//总成本
@property (assign, nonatomic) CGFloat profit;//利润
@property (assign, nonatomic) CGFloat discount;//折扣(利润=总价-成本-运费-折扣)
@property (assign, nonatomic) BOOL isFinish;//是否完成交易
@property (strong, nonatomic, nullable) NSMutableArray *orderGoodsList;//QXOrderGoodsModel元素的数组
- (void)store;//insert data
- (void)refresh;//update data
- (void)remove;//delete data
- (NSArray*)fetchAll;//select all data
- (QXOrderModel*)fetchModel;//select model with uid
- (NSArray*)fetchWithKeyword:(NSString*)keyword;//select models with keyword
- (NSArray*)fetchWithIsFinish:(BOOL)isFinish;//select models with isFinish
@end
NS_ASSUME_NONNULL_END
