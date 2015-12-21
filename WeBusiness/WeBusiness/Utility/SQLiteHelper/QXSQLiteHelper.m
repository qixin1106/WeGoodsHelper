//
//  QXSQLiteHelper.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXSQLiteHelper.h"

static FMDatabaseQueue *_databaseQueue = nil;
@implementation QXSQLiteHelper


+ (NSString*)dbPath
{
    return [[QXFileUtil userDataPath] stringByAppendingPathComponent:@"WeBusiness.db"];
}


+ (void)createDBFile
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[QXSQLiteHelper dbPath]])
    {
        NSData *dbFile = [NSData data];
        [dbFile writeToFile:[QXSQLiteHelper dbPath] atomically:YES];
    }
}



+ (FMDatabaseQueue*)sharedDatabaseQueue
{
    @synchronized(_databaseQueue)
    {
        if (!_databaseQueue)
        {
            [QXSQLiteHelper createDBFile];
            _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[QXSQLiteHelper dbPath]];
        }
        return _databaseQueue;
    }
}


+ (void)closeQueue
{
    if (_databaseQueue)
    {
        [_databaseQueue close];
        _databaseQueue = nil;
    }
}







@end
