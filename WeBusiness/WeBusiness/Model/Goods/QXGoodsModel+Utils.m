//
//  QXGoodsModel+Utils.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsModel+Utils.h"

@implementation QXGoodsModel (Utils)


- (NSString*)costPriceToString
{
    return STR_FORMAT(@"￥%.2f",self.costPrice);
}
- (NSString*)delegatePriceToString
{
    return STR_FORMAT(@"￥%.2f",self.delegatePrice);
}
- (NSString*)friendPriceToString
{
    return STR_FORMAT(@"￥%.2f",self.friendPrice);
}
- (NSString*)retailPriceToString
{
    return STR_FORMAT(@"￥%.2f",self.retailPrice);
}
- (NSString*)countToString
{
    return STR_FORMAT(@"%ld件",self.count);
}


@end
