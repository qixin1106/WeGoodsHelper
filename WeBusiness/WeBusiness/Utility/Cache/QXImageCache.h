//
//  QXImageCache.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QXImageCache : NSObject
+ (instancetype)shared;
- (UIImage*)imageWithID:(NSString*)ID;
- (void)saveImage:(UIImage*)image picID:(NSString*)picID;
- (void)removeWithPicID:(NSString*)picID;
@end
