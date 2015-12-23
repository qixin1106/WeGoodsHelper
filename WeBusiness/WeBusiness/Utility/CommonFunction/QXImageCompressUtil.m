//
//  QXImageCompressUtil.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXImageCompressUtil.h"

@implementation QXImageCompressUtil

#pragma mark - 图片压缩处理---------------------------------------
#pragma mark 压缩图片到指定尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image
                    scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 压缩图片按比例如0.5就是长宽缩一半
+ (UIImage*)imageWithImageSimple:(UIImage*)image
                           ratio:(float)ratio
{
    float w = image.size.width;
    float h = image.size.height;
    CGSize newSize = CGSizeMake(w*ratio, h*ratio);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark 按宽度等比压缩
+ (UIImage*)imageWithImageSimple:(UIImage *)image width:(float)width
{
    int cw = width;
    int ch = width*image.size.height/image.size.width;
    
    CGSize newSize = CGSizeMake(cw, ch);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



#pragma mark 异步压缩图片调取的是按宽等比压缩法[朋友圈图片压缩法]
+ (void)compressImage:(UIImage*)img
          compressEnd:(CompressEnd)compressEnd
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @autoreleasepool
        {
            NSData *imgData = [QXImageCompressUtil syncCompressImage:img];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (compressEnd)
                {
                    compressEnd([UIImage imageWithData:imgData]);
                }
            });
        }
    });
}


#pragma mark - 同步压缩图片
+ (NSData*)syncCompressImage:(UIImage*)img
{
    UIImage *compressImage;
    if (img.size.width>960)
    {
        compressImage = [QXImageCompressUtil imageWithImageSimple:img
                                                      width:960];
    }
    else
    {
        compressImage = img;
    }
    NSData *imgData = UIImageJPEGRepresentation(compressImage, 0.5);
    NSLog(@"压缩后图片大小%lu",(unsigned long)[imgData length]);
    return imgData;
}


@end
