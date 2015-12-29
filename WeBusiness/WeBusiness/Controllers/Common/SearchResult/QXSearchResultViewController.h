//
//  QXSearchResultViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/29.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, SearchType) {
    SearchType_Order,
    SearchType_Goods,
    SearchType_Customer,
};
@interface QXSearchResultViewController : QXBaseTableViewController
@property (assign, nonatomic) SearchType searchType;
@property (strong, nonatomic, nullable) NSMutableArray *resultArray;
- (instancetype)initWithStyle:(UITableViewStyle)style searchType:(SearchType)searchType;
@end
NS_ASSUME_NONNULL_END