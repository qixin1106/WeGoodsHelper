//
//  UIImageView+FitScale.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FitScale)
//根据宽度等比适配缩放尺寸.
- (void)scaleWithWidth:(CGFloat)width;
@end
