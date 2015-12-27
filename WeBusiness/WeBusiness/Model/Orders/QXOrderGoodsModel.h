//
//  QXOrderGoodsModel.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/25.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface QXOrderGoodsModel : QXBaseModel
@property (copy, nonatomic, nullable) NSString *orderID;//订单ID
@property (copy, nonatomic, nullable) NSString *goodsID;//商品ID
@property (assign, nonatomic) NSInteger buyCount;//购买数量
@property (assign, nonatomic) CGFloat adjustCost;//调整后的成本价
@property (assign, nonatomic) CGFloat adjustPrice;//调整后的出售价
- (void)store;//insert data
- (void)refresh;//update data
- (void)remove;//delete data
- (NSArray*)fetchWithOrderID:(NSString*)orderID;//select by orderID
- (QXOrderGoodsModel*)fetchModel;//select model with uid
@end
NS_ASSUME_NONNULL_END