//
//  QXOrderGoodsModel.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/25.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderGoodsModel.h"

@implementation QXOrderGoodsModel

#pragma mark - Private
- (void)createTable:(FMDatabase*)db
{
    if (![self isExistTable:@"ORDERGOODS" db:db])
    {
        NSString *SQLString =
        @"CREATE TABLE ORDERGOODS (ID VARCHAR PRIMARY KEY NOT NULL UNIQUE, ORDERID VARCHAR, GOODSID VARCHAR, BUYCOUNT INTEGER, ADJUSTCOST FLOAT, ADJUSTPRICE FLOAT, TS DOUBLE)";
        [db executeUpdate:SQLString];
    }
}


- (void)insert:(FMDatabase*)db
{
    NSString *SQLString = @"INSERT INTO ORDERGOODS (ID, ORDERID, GOODSID, BUYCOUNT, ADJUSTCOST, ADJUSTPRICE, TS) VALUES (?,?,?,?,?,?,?)";
    [db executeUpdate:SQLString,self.ID,self.orderID,self.goodsID,@(self.buyCount),@(self.adjustCost),@(self.adjustPrice),@(CFAbsoluteTimeGetCurrent())];
}


- (void)update:(FMDatabase*)db
{
    NSString *SQLString = @"UPDATE ORDERGOODS SET ORDERID=?, GOODSID=?, BUYCOUNT=?, ADJUSTCOST=?, ADJUSTPRICE=? WHERE ID=?";
    [db executeUpdate:SQLString,self.orderID,self.goodsID,@(self.buyCount),@(self.adjustCost),@(self.adjustPrice),self.ID];
}


- (void)delete:(FMDatabase*)db
{
    NSString *SQLString = @"DELETE FROM ORDERGOODS WHERE ID=?";
    [db executeUpdate:SQLString,self.ID];
}


- (NSArray*)selectModel:(FMDatabase*)db orderID:(NSString*)orderID
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM ORDERGOODS WHERE ORDERID=? ORDER BY TS DESC";
    FMResultSet *rs = [db executeQuery:SQLString,orderID];
    while ([rs next])
    {
        [array addObject:[self assignWithResultSet:rs]];
    }
    return array;
}


- (QXOrderGoodsModel*)selectModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = STR_FORMAT(@"SELECT * FROM ORDERGOODS WHERE ID=?");
    FMResultSet *rs = [db executeQuery:SQLString,self.ID];
    while ([rs next])
    {
        [array addObject:[self assignWithResultSet:rs]];
    }
    return [array firstObject];
}




- (QXOrderGoodsModel*)assignWithResultSet:(FMResultSet*)rs
{
    QXOrderGoodsModel *model = [[QXOrderGoodsModel alloc] init];
    model.ID = [rs stringForColumn:@"ID"];
    model.orderID = [rs stringForColumn:@"ORDERID"];
    model.goodsID = [rs stringForColumn:@"GOODSID"];
    model.buyCount = [rs longForColumn:@"BUYCOUNT"];
    model.adjustCost = [rs doubleForColumn:@"ADJUSTCOST"];
    model.adjustPrice = [rs doubleForColumn:@"ADJUSTPRICE"];
    model.ts = [rs doubleForColumn:@"TS"];
    return model;
}





#pragma mark - Public
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


- (NSArray*)fetchWithOrderID:(NSString*)orderID
{
    __block NSArray *array;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        array = [self selectModel:db orderID:orderID];
    }];
    return array;
}


- (QXOrderGoodsModel*)fetchModel
{
    __block QXOrderGoodsModel *model;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        model = [self selectModel:db];
    }];
    return model;
}



@end
