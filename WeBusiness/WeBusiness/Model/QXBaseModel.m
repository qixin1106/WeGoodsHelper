//
//  QXBaseModel.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseModel.h"

@implementation QXBaseModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.ts = CFAbsoluteTimeGetCurrent();
    }
    return self;
}


- (BOOL)isExistTable:(NSString *)tableName db:(FMDatabase*)db;
{
    BOOL isExist = NO;
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        QXLog(@"[%@]表是否存在 %ld",tableName, count);
        if (count)
        {
            isExist = YES;
        }
    }
    return isExist;
}


@end
