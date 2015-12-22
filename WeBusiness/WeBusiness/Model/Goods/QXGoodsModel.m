//
//  QXGoodsModel.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/21.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsModel.h"

@implementation QXGoodsModel


- (void)createTable:(FMDatabase*)db
{
    if (![self isExistTable:@"GOODS" db:db])
    {
        NSString *SQLString = @"CREATE TABLE GOODS (ID VARCHAR PRIMARY KEY NOT NULL UNIQUE, NAME VARCHAR, COST FLOAT, DELEGATE FLOAT, FRIEND FLOAT, RETAIL FLOAT, COUNT INTEGER, DESCS VARCHAR, PICID VARCHAR, REMARK VARCHAR, TS DOUBLE)";
        [db executeUpdate:SQLString];
    }
}


- (void)insert:(FMDatabase*)db
{
    NSString *SQLString = @"INSERT INTO GOODS (ID, NAME, COST, DELEGATE, FRIEND, RETAIL, COUNT, DESCS, PICID, REMARK, TS) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
    [db executeUpdate:SQLString,self.ID,self.name,@(self.costPrice),@(self.delegatePrice),@(self.friendPrice),@(self.retailPrice),@(self.count),self.descs,self.picID,self.remark,@(self.ts)];
}


- (void)update:(FMDatabase*)db
{
    NSString *SQLString = @"UPDATE GOODS SET NAME=?, COST=?, DELEGATE=?, FRIEND=?, RETAIL=?, COUNT=?, DESCS=?, PICID=?, REMARK=? WHERE ID=?";
    [db executeUpdate:SQLString,self.name,@(self.costPrice),@(self.delegatePrice),@(self.friendPrice),@(self.retailPrice),@(self.count),self.descs,self.picID,self.remark,self.ID];
}

- (void)delete:(FMDatabase*)db
{
    NSString *SQLString = @"DELETE FROM GOODS WHERE ID=?";
    [db executeUpdate:SQLString,self.ID];
}


- (NSArray*)selectAll:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM GOODS ORDER BY TS DESC";
    FMResultSet *rs = [db executeQuery:SQLString];
    while ([rs next])
    {
        QXGoodsModel *model = [[QXGoodsModel alloc] init];
        model.ID = [rs stringForColumn:@"ID"];
        model.name = [rs stringForColumn:@"NAME"];
        model.costPrice = [rs doubleForColumn:@"COST"];
        model.delegatePrice = [rs doubleForColumn:@"DELEGATE"];
        model.friendPrice = [rs doubleForColumn:@"FRIEND"];
        model.retailPrice = [rs doubleForColumn:@"RETAIL"];
        model.count = [rs longForColumn:@"COUNT"];
        model.descs = [rs stringForColumn:@"DESCS"];
        model.picID = [rs stringForColumn:@"PICID"];
        model.remark = [rs stringForColumn:@"REMARK"];
        model.ts = [rs doubleForColumn:@"TS"];
        [array addObject:model];
    }
    return array;
}


- (QXGoodsModel*)selectModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = STR_FORMAT(@"SELECT * FROM GOODS WHERE ID=?");
    FMResultSet *rs = [db executeQuery:SQLString,self.ID];
    while ([rs next])
    {
        QXGoodsModel *model = [[QXGoodsModel alloc] init];
        model.ID = [rs stringForColumn:@"ID"];
        model.name = [rs stringForColumn:@"NAME"];
        model.costPrice = [rs doubleForColumn:@"COST"];
        model.delegatePrice = [rs doubleForColumn:@"DELEGATE"];
        model.friendPrice = [rs doubleForColumn:@"FRIEND"];
        model.retailPrice = [rs doubleForColumn:@"RETAIL"];
        model.count = [rs longForColumn:@"COUNT"];
        model.descs = [rs stringForColumn:@"DESCS"];
        model.picID = [rs stringForColumn:@"PICID"];
        model.remark = [rs stringForColumn:@"REMARK"];
        model.ts = [rs doubleForColumn:@"TS"];
        [array addObject:model];
    }
    return [array firstObject];
}



- (void)store
{
    [[QXSQLiteHelper sharedDatabaseQueue] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [self createTable:db];
        [self insert:db];
    }];
}

- (void)refresh
{
    [[QXSQLiteHelper sharedDatabaseQueue] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [self createTable:db];
        [self update:db];
    }];
}


- (void)remove
{
    [[QXSQLiteHelper sharedDatabaseQueue] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [self createTable:db];
        [self delete:db];
    }];
}


- (NSArray*)fetchAll
{
    __block NSArray *array;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        array = [self selectAll:db];
    }];
    return array;
}


- (QXGoodsModel*)fetchModel
{
    __block QXGoodsModel *model;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        model = [self selectModel:db];
    }];
    return model;
}

@end
