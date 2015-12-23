//
//  UIImage+Utils.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
//通过picID获取本地图片
+ (UIImage*)imageWithPicID:(NSString*)picID;
+ (UIImage*)imageWithPicID:(NSString*)picID isThumb:(BOOL)isThumb;
//保存图片到磁盘
- (void)saveWithID:(NSString*)ID;
//删除缓存内存及磁盘
+ (void)removeCacheWithID:(NSString*)ID;


//区域截屏
+ (UIImage*)screenShotWithView:(UIView*)view;
@end
