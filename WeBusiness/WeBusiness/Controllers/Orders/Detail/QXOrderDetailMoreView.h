//
//  QXOrderDetailMoreView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/29.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QXOrderGoodsModel;

@protocol QXOrderDetailMoreViewDelegate;
@interface QXOrderDetailMoreView : UIControl
@property (strong, nonatomic) QXOrderGoodsModel *model;
@property (weak, nonatomic) id<QXOrderDetailMoreViewDelegate>delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@protocol QXOrderDetailMoreViewDelegate <NSObject>
- (void)changeValueCallback:(QXOrderDetailMoreView*)moreView;
@end
