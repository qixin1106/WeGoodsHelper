//
//  QXImageCache.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXImageCache.h"



static QXImageCache *_imagecahce = nil;
@interface QXImageCache ()
@property (strong, nonatomic) NSCache *cache;
@end
@implementation QXImageCache


- (void)didReceiveMemoryWarningNotification:(NSNotification*)sender
{
    [self.cache removeAllObjects];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cache = [[NSCache alloc] init];
        self.cache.name = @"com.qixin.imagecache";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}



+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imagecahce = [[QXImageCache alloc] init];
    });
    return _imagecahce;
}



- (UIImage*)imageWithID:(NSString*)ID
{
    UIImage *image = [self.cache objectForKey:ID];
    if (!image)
    {
        NSString *path = [[QXFileUtil assetsPath] stringByAppendingPathComponent:STR_FORMAT(@"%@.png",ID)];
        image = [UIImage imageWithData:[NSData dataWithContentsOfFile:path options:NSDataReadingMapped error:nil]];
        if (image)
        {
            [self.cache setObject:image forKey:ID];
            return image;
        }
    }
    return image;
}

- (void)saveImage:(UIImage*)image picID:(NSString*)picID
{
    [self.cache setObject:image forKey:picID];
    NSString *path = [[QXFileUtil assetsPath] stringByAppendingPathComponent:STR_FORMAT(@"%@.png",picID)];
    NSData *data = UIImageJPEGRepresentation(image, IMAGE_COMPRESS_RATE);
    [data writeToFile:path atomically:YES];
}


- (void)removeWithPicID:(NSString*)picID
{
    [self.cache removeObjectForKey:picID];
    NSString *path = [[QXFileUtil assetsPath] stringByAppendingPathComponent:STR_FORMAT(@"%@.png",picID)];
    NSString *path_s = [[QXFileUtil assetsPath] stringByAppendingPathComponent:STR_FORMAT(@"%@_s.png",picID)];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])//删除大图
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:path_s])//删除缩略
    {
        [[NSFileManager defaultManager] removeItemAtPath:path_s error:nil];
    }
}



@end
