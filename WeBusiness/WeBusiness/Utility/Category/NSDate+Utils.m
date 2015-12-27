//
//  NSDate+Utils.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/27.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)
+ (NSString *)dateToString:(CFTimeInterval)ts
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ts];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
@end
