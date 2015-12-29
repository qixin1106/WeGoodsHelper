//
//  QXCustomerModel.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerModel.h"
#import "QXCustomerModel+TypeTranslation.h"
@implementation QXCustomerModel



#pragma mark - Private
- (void)createTable:(FMDatabase*)db
{
    if (![self isExistTable:@"CUSTOMER" db:db])
    {
        NSString *SQLString = @"CREATE TABLE CUSTOMER (ID varchar NOT NULL PRIMARY KEY UNIQUE,NAME varchar,PINYIN varchar,PYSORT varchar,TEL varchar,ADDRESS varchar,WECHATID varchar,TYPE integer,PICID varchar,TS double)";
        [db executeUpdate:SQLString];
    }
}


- (void)insert:(FMDatabase*)db
{
    NSString *SQLString = @"INSERT INTO CUSTOMER (ID,NAME,PINYIN,PYSORT,TEL,ADDRESS,WECHATID,TYPE,PICID,TS) VALUES (?,?,?,?,?,?,?,?,?,?)";
    [db executeUpdate:SQLString,self.ID,self.name,[self nameToPinyin],[self nameToPinyinFirstChar],self.tel,self.address,self.wechatID,@(self.type),self.picID,@(CFAbsoluteTimeGetCurrent())];
}


- (void)update:(FMDatabase*)db
{
    NSString *SQLString = @"UPDATE CUSTOMER SET NAME=?,PINYIN=?,PYSORT=?,TEL=?,ADDRESS=?,WECHATID=?,TYPE=?,PICID=? WHERE ID=?";
    [db executeUpdate:SQLString,self.name,[self nameToPinyin],[self nameToPinyinFirstChar],self.tel,self.address,self.wechatID,@(self.type),self.picID,self.ID];
}

- (void)delete:(FMDatabase*)db
{
    NSString *SQLString = @"DELETE FROM CUSTOMER WHERE ID=?";
    [db executeUpdate:SQLString,self.ID];
}


- (NSArray*)selectAllModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM CUSTOMER ORDER BY PYSORT";
    FMResultSet *rs = [db executeQuery:SQLString];
    while ([rs next])
    {
        QXCustomerModel *model = [[array lastObject] firstObject];
        if (model && [model.pySort isEqualToString:[[self assignWithResultSet:rs] pySort]])
        {
            [[array lastObject] addObject:[self assignWithResultSet:rs]];
        }
        else
        {
            NSMutableArray *pyArr = [NSMutableArray array];
            [pyArr addObject:[self assignWithResultSet:rs]];
            [array addObject:pyArr];
        }
        //[array addObject:[self assignWithResultSet:rs]];
    }
    return array;
}


- (QXCustomerModel*)selectModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = STR_FORMAT(@"SELECT * FROM CUSTOMER WHERE ID=?");
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
    NSString *SQLString = @"SELECT * FROM CUSTOMER \
    WHERE NAME LIKE ? \
    OR NAME LIKE ? \
    OR NAME LIKE ? \
    OR ADDRESS LIKE ? \
    OR ADDRESS LIKE ? \
    OR ADDRESS LIKE ? \
    OR TEL LIKE ? \
    OR TEL LIKE ? \
    OR TEL LIKE ? \
    OR PINYIN LIKE ? \
    OR PINYIN LIKE ? \
    OR PINYIN LIKE ? \
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


- (NSArray*)selectPinYinSort:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = STR_FORMAT(@"SELECT PYSORT FROM CUSTOMER ORDER BY PYSORT");
    FMResultSet *rs = [db executeQuery:SQLString];
    while ([rs next])
    {
        [array addObject:[rs stringForColumn:@"PYSORT"]];
    }
    return array;
}



- (QXCustomerModel*)assignWithResultSet:(FMResultSet*)rs
{
    QXCustomerModel *model = [[QXCustomerModel alloc] init];
    model.ID = [rs stringForColumn:@"ID"];
    model.name = [rs stringForColumn:@"NAME"];
    model.pinyin = [rs stringForColumn:@"PINYIN"];
    model.pySort = [rs stringForColumn:@"PYSORT"];
    model.tel = [rs stringForColumn:@"TEL"];
    model.address = [rs stringForColumn:@"ADDRESS"];
    model.wechatID = [rs stringForColumn:@"WECHATID"];
    model.type = [rs longForColumn:@"TYPE"];
    model.picID = [rs stringForColumn:@"PICID"];
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


- (QXCustomerModel*)fetchModel
{
    __block QXCustomerModel *model;
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


- (NSArray*)fetchPinYinSortArray
{
    __block NSArray *array;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        array = [self selectPinYinSort:db];
    }];
    return array;
}

@end
