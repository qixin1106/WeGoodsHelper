//
//  QXGoodsModel.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/21.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseModel.h"


NS_ASSUME_NONNULL_BEGIN


static NSString *kGoodsRefresh = @"kGoodsRefresh";

@interface QXGoodsModel : QXBaseModel
@property (copy, nonatomic, nullable) NSString *name;//商品名
@property (assign, nonatomic) CGFloat costPrice;//进价
@property (assign, nonatomic) CGFloat delegatePrice;//代理价
@property (assign, nonatomic) CGFloat friendPrice;//友情价
@property (assign, nonatomic) CGFloat retailPrice;//单价
@property (assign, nonatomic) NSInteger count;//数量
@property (copy, nonatomic, nullable) NSString *descs;//商品描述
@property (copy, nonatomic, nullable) NSString *picID;//图片
@property (copy, nonatomic, nullable) NSString *remark;//备注

- (void)store;//insert data
- (void)refresh;//update data
- (void)remove;//delete data
- (NSArray*)fetchAll;//select all data
- (QXGoodsModel*)fetchModel;//select model with uid
- (NSArray*)fetchWithKeyword:(NSString*)keyword;//select models with keyword
@end
NS_ASSUME_NONNULL_END