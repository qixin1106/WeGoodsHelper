//
//  QXImageCompressUtil.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QXImageCompressUtil : NSObject
#pragma mark - 图片压缩处理---------------------------------------
#pragma mark 压缩图片到指定尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image
                    scaledToSize:(CGSize)newSize;

#pragma mark 压缩图片按比例如0.5就是长宽缩一半
+ (UIImage*)imageWithImageSimple:(UIImage*)image
                           ratio:(float)ratio;


#pragma mark 按宽度等比压缩
+ (UIImage*)imageWithImageSimple:(UIImage *)image width:(float)width;



#pragma mark 异步压缩图片调取的是按宽等比压缩法[朋友圈图片压缩法]
typedef void (^CompressEnd)(UIImage*img);
+ (void)compressImage:(UIImage*)img
          compressEnd:(CompressEnd)compressEnd;


#pragma mark - 同步压缩图片
+ (NSData*)syncCompressImage:(UIImage*)img;

@end
