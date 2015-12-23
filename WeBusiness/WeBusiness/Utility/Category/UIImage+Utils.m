//
//  UIImage+Utils.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "UIImage+Utils.h"
#import "QXImageCache.h"


@implementation UIImage (Utils)


+ (UIImage*)imageWithPicID:(NSString*)picID
{
    return [UIImage imageWithPicID:picID isThumb:NO];
}

+ (UIImage*)imageWithPicID:(NSString*)picID isThumb:(BOOL)isThumb
{
    return [[QXImageCache shared] imageWithID:(isThumb)?STR_FORMAT(@"%@_s",picID):picID];
}


- (void)saveWithID:(NSString*)ID
{
    [[QXImageCache shared] saveImage:self picID:ID];
}



- (void)removeCacheWithID:(NSString*)ID;
{
    [[QXImageCache shared] removeWithPicID:ID];
}


+ (UIImage*)screenShotWithView:(UIView*)view
{
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width, view.frame.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}


@end
