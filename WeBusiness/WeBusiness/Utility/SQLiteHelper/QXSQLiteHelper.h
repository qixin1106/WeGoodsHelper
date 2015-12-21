//
//  QXSQLiteHelper.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QXSQLiteHelper : NSObject
+ (FMDatabaseQueue*)sharedDatabaseQueue;
+ (void)closeQueue;
@end
