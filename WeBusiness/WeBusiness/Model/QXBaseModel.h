//
//  QXBaseModel.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface QXBaseModel : NSObject
@property (copy, nonatomic) NSString *ID;
@property (assign, nonatomic) CFTimeInterval ts;

- (BOOL)isExistTable:(NSString *)tableName db:(FMDatabase*)db;
@end
