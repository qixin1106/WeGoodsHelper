//
//  QXInputStringViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/21.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditDoneBlock)(NSString * string);
@interface QXInputStringViewController : UIViewController
@property (copy, nonatomic) NSString *placeHolder;
@property (copy, nonatomic) EditDoneBlock editDoneBlock;
@property (nonatomic) UIKeyboardType keyboardType;
@end
