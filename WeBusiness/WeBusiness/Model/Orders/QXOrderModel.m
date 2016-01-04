//
//  QXOrderModel.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/24.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderModel.h"
#import "QXOrderGoodsModel.h"

@implementation QXOrderModel


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.orderGoodsList = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Private
- (void)createTable:(FMDatabase*)db
{
    if (![db tableExists:@"ORDERS"])
    {
        NSString *SQLString = @"CREATE TABLE ORDERS (ID varchar NOT NULL PRIMARY KEY UNIQUE,NAME varchar,TEL varchar,ADDRESS varchar,CN varchar,REMARK varchar,ORDERTIME double,FREIGHT double,PRICE double,COST double,PROFIT double,DISCOUNT double,ISFINISH boolean,TS double)";
        [db executeUpdate:SQLString];
    }
}


- (void)insert:(FMDatabase*)db
{
    NSString *SQLString = @"INSERT INTO ORDERS (ID, NAME, TEL, ADDRESS, CN, REMARK, ORDERTIME, FREIGHT, PRICE, COST, PROFIT ,DISCOUNT, ISFINISH, TS) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    [db executeUpdate:SQLString,self.ID,self.name,self.tel,self.address,self.cn,self.remark,@(self.buyerOrderTime),@(self.freight),@(self.price),@(self.cost),@(self.profit),@(self.discount),@(self.isFinish),@(CFAbsoluteTimeGetCurrent())];
}


- (void)update:(FMDatabase*)db
{
    NSString *SQLString = @"UPDATE ORDERS SET NAME=?, TEL=?, ADDRESS=?, CN=?, REMARK=?, ORDERTIME=?, FREIGHT=?, PRICE=?, COST=?, PROFIT=?, DISCOUNT=?, ISFINISH=? WHERE ID=?";
    [db executeUpdate:SQLString,self.name,self.tel,self.address,self.cn,self.remark,@(self.buyerOrderTime),@(self.freight),@(self.price),@(self.cost),@(self.profit),@(self.discount),@(self.isFinish),self.ID];
}

- (void)delete:(FMDatabase*)db
{
    NSString *SQLString = @"DELETE FROM ORDERS WHERE ID=?";
    [db executeUpdate:SQLString,self.ID];
}


- (NSArray*)selectAllModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM ORDERS ORDER BY TS DESC";
    FMResultSet *rs = [db executeQuery:SQLString];
    while ([rs next])
    {
        [array addObject:[self assignWithResultSet:rs]];
    }
    return array;
}


- (QXOrderModel*)selectModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = STR_FORMAT(@"SELECT * FROM ORDERS WHERE ID=?");
    FMResultSet *rs = [db executeQuery:SQLString,self.ID];
    while ([rs next])
    {
        [array addObject:[self assignWithResultSet:rs]];
    }
    return [array firstObject];
}


- (NSArray*)selectWithKeyword:(NSString*)keyword db:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM ORDERS \
    WHERE NAME LIKE ? \
    OR NAME LIKE ? \
    OR NAME LIKE ? \
    OR ADDRESS LIKE ? \
    OR ADDRESS LIKE ? \
    OR ADDRESS LIKE ? \
    OR TEL LIKE ? \
    OR TEL LIKE ? \
    OR TEL LIKE ? \
    OR CN LIKE ? \
    OR CN LIKE ? \
    OR CN LIKE ? \
    ORDER BY TS DESC";
    FMResultSet *rs = [db executeQuery:SQLString,
                       STR_FORMAT(@"%@%@",keyword,@"%"),
                       STR_FORMAT(@"%@%@",@"%",keyword),
                       STR_FORMAT(@"%@%@%@",@"%",keyword,@"%"),
                       STR_FORMAT(@"%@%@",keyword,@"%"),
                       STR_FORMAT(@"%@%@",@"%",keyword),
                       STR_FORMAT(@"%@%@%@",@"%",keyword,@"%"),
                       STR_FORMAT(@"%@%@",keyword,@"%"),
                       STR_FORMAT(@"%@%@",@"%",keyword),
                       STR_FORMAT(@"%@%@%@",@"%",keyword,@"%"),
                       STR_FORMAT(@"%@%@",keyword,@"%"),
                       STR_FORMAT(@"%@%@",@"%",keyword),
                       STR_FORMAT(@"%@%@%@",@"%",keyword,@"%")];
    while ([rs next])
    {
        [array addObject:[self assignWithResultSet:rs]];
    }
    return array;
}

- (NSArray*)selectWithIsFinish:(BOOL)isFinish db:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM ORDERS WHERE ISFINISH=? ORDER BY TS DESC";
    FMResultSet *rs = [db executeQuery:SQLString,@(isFinish)];
    while ([rs next])
    {
        [array addObject:[self assignWithResultSet:rs]];
    }
    return array;
}



- (QXOrderModel*)assignWithResultSet:(FMResultSet*)rs
{
    QXOrderModel *model = [[QXOrderModel alloc] init];
    model.ID = [rs stringForColumn:@"ID"];
    model.name = [rs stringForColumn:@"NAME"];
    model.tel = [rs stringForColumn:@"TEL"];
    model.address = [rs stringForColumn:@"ADDRESS"];
    model.cn = [rs stringForColumn:@"CN"];
    model.remark = [rs stringForColumn:@"REMARK"];
    model.buyerOrderTime = [rs doubleForColumn:@"ORDERTIME"];
    model.freight = [rs doubleForColumn:@"FREIGHT"];
    model.price = [rs doubleForColumn:@"PRICE"];
    model.cost = [rs doubleForColumn:@"COST"];
    model.profit = [rs doubleForColumn:@"PROFIT"];
    model.discount = [rs doubleForColumn:@"DISCOUNT"];
    model.isFinish = [rs boolForColumn:@"ISFINISH"];
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

- (NSArray*)fetchAll
{
    __block NSArray *array;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        array = [self selectAllModel:db];
    }];
    return array;
}


- (QXOrderModel*)fetchModel
{
    __block QXOrderModel *model;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        model = [self selectModel:db];
    }];
    return model;
}


- (NSArray*)fetchWithKeyword:(NSString*)keyword
{
    __block NSArray *array;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        array = [self selectWithKeyword:keyword db:db];
    }];
    return array;
}


- (NSArray*)fetchWithIsFinish:(BOOL)isFinish
{
    __block NSArray *array;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        array = [self selectWithIsFinish:isFinish db:db];
    }];
    return array;
}


@end
