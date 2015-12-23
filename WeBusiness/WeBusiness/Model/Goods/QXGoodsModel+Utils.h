//
//  QXGoodsModel+Utils.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsModel.h"

@interface QXGoodsModel (Utils)
- (NSString*)costPriceToString;
- (NSString*)delegatePriceToString;
- (NSString*)friendPriceToString;
- (NSString*)retailPriceToString;
- (NSString*)countToString;

//增加一个图片id
- (void)addPicID:(NSString*)picID;
//删除一个图片id
- (void)removePicID:(NSString*)picID;
@end
