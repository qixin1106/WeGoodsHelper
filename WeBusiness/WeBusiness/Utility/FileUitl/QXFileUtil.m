//
//  QXFileUtil.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/20.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXFileUtil.h"


#define USER_DATA_PATH @"UserData"
#define ASSETS_PATH @"Assets"


@implementation QXFileUtil


+ (void)creatFilePath:(NSString*)path
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}




+ (NSString*)userDataPath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:USER_DATA_PATH];
}


+ (NSString*)assetsPath
{
    return [[QXFileUtil userDataPath] stringByAppendingPathComponent:ASSETS_PATH];
}


+ (void)createProjectNecessaryPath
{
    QXLog(@"用户路径=%@",[QXFileUtil userDataPath]);
    //用户数据主文件夹
    [QXFileUtil creatFilePath:[QXFileUtil userDataPath]];
    
    //资产缓存路径
    [QXFileUtil creatFilePath:[QXFileUtil assetsPath]];

}



@end
