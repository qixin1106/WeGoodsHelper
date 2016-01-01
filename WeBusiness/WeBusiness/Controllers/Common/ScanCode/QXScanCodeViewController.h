//
//  QXScanCodeViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 16/1/2.
//  Copyright © 2016年 亓鑫. All rights reserved.
//

#import "QXBaseViewController.h"

@protocol QXScanCodeViewControllerDelegate;
@interface QXScanCodeViewController : QXBaseViewController
@property (weak, nonatomic) id<QXScanCodeViewControllerDelegate> delegate;
@end

@protocol QXScanCodeViewControllerDelegate <NSObject>
- (void)scanCodeFinish:(QXScanCodeViewController*)vc code:(NSString*)code;
@end
