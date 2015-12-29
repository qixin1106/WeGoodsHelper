//
//  QXCustomerModel+TypeTranslation.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/21.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerModel+TypeTranslation.h"

@implementation QXCustomerModel (TypeTranslation)
- (NSString*)typeToString
{
    switch (self.type)
    {
        case 0:
        {
            return @"客户";
            break;
        }
        case 1:
        {
            return @"代理";
            break;
        }
        case 2:
        {
            return @"朋友";
            break;
        }
        default:
            return @"未知";
            break;
    }
}



- (NSString*)nameToPinyin
{
    NSMutableString *pinyin = [self.name mutableCopy];
    //转换成拼音
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *py = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [py lowercaseString];
}




- (NSString*)nameToPinyinFirstChar
{
    NSString *str = [self nameToPinyin];
    if (VALID_STRING(str))
    {
        return [[str substringToIndex:1] uppercaseString];
    }
    return nil;
}


@end
