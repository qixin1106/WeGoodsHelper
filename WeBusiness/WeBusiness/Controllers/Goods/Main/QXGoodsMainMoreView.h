//
//  QXGoodsMainMoreView.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/24.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol QXGoodsMainMoreViewDelegate;
@interface QXGoodsMainMoreView : UIControl
@property (weak, nonatomic, nullable) id<QXGoodsMainMoreViewDelegate>delegate;
@end


@protocol QXGoodsMainMoreViewDelegate <NSObject>

@end
NS_ASSUME_NONNULL_END