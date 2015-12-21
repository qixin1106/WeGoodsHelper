//
//  QXCustomerModel.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerModel.h"



@implementation QXCustomerModel


- (void)createTable:(FMDatabase*)db
{
    if (![self isExistTable:@"CUSTOMER" db:db])
    {
        NSString *SQLString = @"CREATE TABLE CUSTOMER (UID integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,NAME varchar,TEL varchar,ADDRESS varchar,WECHATID varchar,TYPE integer,PICID varchar,TS double)";
        [db executeUpdate:SQLString];
    }
}




- (void)insert:(FMDatabase*)db
{
    /*
     @property (assign, nonatomic) NSInteger uid;
     @property (copy, nonatomic, nullable) NSString *name;
     @property (copy, nonatomic, nullable) NSString *tel;
     @property (copy, nonatomic, nullable) NSString *address;
     @property (copy, nonatomic, nullable) NSString *wechatID;
     @property (assign, nonatomic) NSInteger type;
     @property (copy, nonatomic, nullable) NSString *picID;
     @property (assign, nonatomic) CFTimeInterval ts;
     */
    NSString *SQLString = @"INSERT INTO CUSTOMER (NAME,TEL,ADDRESS,WECHATID,TYPE,PICID,TS) VALUES (?,?,?,?,?,?,?)";
    [db executeUpdate:SQLString,self.name,self.tel,self.address,self.wechatID,@(self.type),self.picID,@(self.ts)];
}


- (void)update:(FMDatabase*)db
{
    NSString *SQLString = @"UPDATE CUSTOMER SET NAME=?,TEL=?,ADDRESS=?,WECHATID=?,TYPE=?,PICID=? WHERE UID=?";
    [db executeUpdate:SQLString,self.name,self.tel,self.address,self.wechatID,@(self.type),self.picID,@(self.uid)];
}

- (void)delete:(FMDatabase*)db
{
    NSString *SQLString = @"DELETE FROM CUSTOMER WHERE UID=?";
    [db executeUpdate:SQLString,@(self.uid)];
}


- (NSArray*)selectAll:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = @"SELECT * FROM CUSTOMER ORDER BY UID DESC";
    FMResultSet *rs = [db executeQuery:SQLString];
    while ([rs next])
    {
        QXCustomerModel *model = [[QXCustomerModel alloc] init];
        model.uid = [rs longForColumn:@"UID"];
        model.name = [rs stringForColumn:@"NAME"];
        model.tel = [rs stringForColumn:@"TEL"];
        model.address = [rs stringForColumn:@"ADDRESS"];
        model.wechatID = [rs stringForColumn:@"WECHATID"];
        model.type = [rs longForColumn:@"TYPE"];
        model.picID = [rs stringForColumn:@"PICID"];
        model.ts = [rs doubleForColumn:@"TS"];
        [array addObject:model];
    }
    return array;
}


- (QXCustomerModel*)selectModel:(FMDatabase*)db
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *SQLString = STR_FORMAT(@"SELECT * FROM CUSTOMER WHERE UID=%ld",self.uid);
    FMResultSet *rs = [db executeQuery:SQLString];
    while ([rs next])
    {
        QXCustomerModel *model = [[QXCustomerModel alloc] init];
        model.uid = [rs longForColumn:@"UID"];
        model.name = [rs stringForColumn:@"NAME"];
        model.tel = [rs stringForColumn:@"TEL"];
        model.address = [rs stringForColumn:@"ADDRESS"];
        model.wechatID = [rs stringForColumn:@"WECHATID"];
        model.type = [rs longForColumn:@"TYPE"];
        model.picID = [rs stringForColumn:@"PICID"];
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


- (QXCustomerModel*)fetchModel
{
    __block QXCustomerModel *model;
    [[QXSQLiteHelper sharedDatabaseQueue] inDatabase:^(FMDatabase *db) {
        [self createTable:db];
        model = [self selectModel:db];
    }];
    return model;
}







@end
