//
//  PSFileManager.m
//  PSOCStudy
//
//  Created by Peng on 2018/6/1.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSFileManager.h"
#import "PS_Head1.h"

static PSFileManager *manager = nil;
static NSFileManager *fileManager = nil;

@implementation PSFileManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PSFileManager new];
        fileManager = [NSFileManager defaultManager];
    });
   return manager;
}

- (NSURL *)ps_applicationDirector {
    NSArray *possibleURLs = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    NSURL *appSupportDir = nil;
    NSURL *dirPath = nil;
    if (possibleURLs.count > 0) {
        // 3.数组不为空时，使用第一个元素。
        appSupportDir = possibleURLs.firstObject;
    }
    
    // 4.如果存在appSupportDir目录，将应用的bundleIdentifier添加到文件结尾，用于创建自定义目录
    if (appSupportDir) {
        NSString *appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        dirPath = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    
    // 5.如果dirPath目录不存在，创建该目录
    NSError *error = nil;
    if (![fileManager createDirectoryAtURL:dirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        DebugLog(@"Couldn't create dirPath.error %@",error);
        return nil;
    }
    return dirPath;
}
- (void)ps_copyDirectoryWith:(NSURL *)url {
    NSURL *appDataDir = [url URLByAppendingPathComponent:@"Data"];
    NSURL *backupDir = [appDataDir URLByAppendingPathExtension:@"backup"];
    if (![fileManager fileExistsAtPath:appDataDir.path]) {
        if (![fileManager createDirectoryAtURL:appDataDir withIntermediateDirectories:YES attributes:nil error:nil]) {
            DebugLog(@"Couldn't create appDataDir");
            return;
        };
    }
    
    // 2.异步执行复制
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 3.使用init方法初始化文件管理器，以便后面可能用到代理方法。
        NSFileManager *theFM = [[NSFileManager alloc] init];
        NSError *anError;
        
        // 4.尝试复制文件
        if (![theFM copyItemAtURL:appDataDir toURL:backupDir error:&anError]) {
            // 5.如果复制失败，可能是backupDir已经存在，删除旧的backupDir文件
            if ([theFM removeItemAtURL:backupDir error:&anError]) {
                // 6.再次复制，如果失败，终止复制操作。
                if (![theFM copyItemAtURL:appDataDir toURL:backupDir error:&anError]) {
                    NSLog(@"anError:%@",anError);
                }
            }
        }
    });
    
}

@end
