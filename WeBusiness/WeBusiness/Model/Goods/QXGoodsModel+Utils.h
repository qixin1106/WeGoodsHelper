//
//  QXGoodsModel+Utils.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsModel.h"

@interface QXGoodsModel (Utils)
/*
 @property (assign, nonatomic) CGFloat costPrice;//进价
 @property (assign, nonatomic) CGFloat delegatePrice;//代理价
 @property (assign, nonatomic) CGFloat friendPrice;//友情价
 @property (assign, nonatomic) CGFloat retailPrice;//单价
 @property (assign, nonatomic) NSInteger count;//数量
 */
- (NSString*)costPriceToString;
- (NSString*)delegatePriceToString;
- (NSString*)friendPriceToString;
- (NSString*)retailPriceToString;
- (NSString*)countToString;

@end
