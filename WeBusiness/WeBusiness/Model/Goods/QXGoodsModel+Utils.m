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
    return STR_FORMAT(@"%.2f",self.costPrice);
}
- (NSString*)delegatePriceToString
{
    return STR_FORMAT(@"%.2f",self.delegatePrice);
}
- (NSString*)friendPriceToString
{
    return STR_FORMAT(@"%.2f",self.friendPrice);
}
- (NSString*)retailPriceToString
{
    return STR_FORMAT(@"%.2f",self.retailPrice);
}
- (NSString*)countToString
{
    return STR_FORMAT(@"%ld",self.count);
}




- (void)addPicID:(NSString*)picID
{
    //保护
    if (!VALID_STRING(picID)){return;}
    
    if (VALID_STRING(self.picID))
    {
        self.picID = STR_FORMAT(@"%@;%@",self.picID,picID);
    }
    else
    {
        self.picID = picID;
    }
}



- (void)removePicID:(NSString*)picID
{
    //保护
    if (!VALID_STRING(picID)){return;}
    
    if (VALID_STRING(self.picID))
    {
        self.picID = [self.picID stringByReplacingOccurrencesOfString:picID withString:@""];
        NSMutableArray *picIDs = [NSMutableArray arrayWithArray:[self.picID componentsSeparatedByString:@";"]];
        NSMutableString *newPicID = [NSMutableString string];
        [picIDs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (VALID_STRING(obj))
            {
                if (newPicID.length)
                {
                    [newPicID appendFormat:@";%@",obj];//后续值
                }
                else
                {
                    [newPicID appendFormat:@"%@",obj];//第一个值
                }
            }
        }];
        self.picID = newPicID;
    }
}


@end
