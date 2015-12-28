//
//  QXGoodsMainViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, Type) {
    Type_Display=0,
    Type_Select=1
};
@class QXGoodsModel;
@protocol QXGoodsMainViewControllerDelegate;
@interface QXGoodsMainViewController : QXBaseTableViewController
@property (weak, nonatomic) id<QXGoodsMainViewControllerDelegate> delegate;
@property (assign, nonatomic) Type type;
@end


@protocol QXGoodsMainViewControllerDelegate <NSObject>
- (void)selectedGoods:(QXGoodsModel*)goodsModel;
@end