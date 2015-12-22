//
//  UIImageView+FitScale.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "UIImageView+FitScale.h"

@implementation UIImageView (FitScale)
- (void)scaleWithWidth:(CGFloat)width
{
    if (self.image)
    {
        CGFloat height = self.image.size.height*width/self.image.size.width;
        self.bounds = CGRectMake(0, 0, width, height);
    }
}
@end
