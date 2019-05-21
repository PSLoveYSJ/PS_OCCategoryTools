//
//  PSFileManager.h
//  PSOCStudy
//
//  Created by Peng on 2018/6/1.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSFileManager : NSObject

+ (instancetype) sharedManager;


/**
 Application Support 目录

 @return URL
 */
- (NSURL *) ps_applicationDirector;


/**
 复制文件 第一次失败 查看是否存在一个备份文件 存在删除备份 再次尝试 失败 报错

 @param url url
 */
- (void) ps_copyDirectoryWith:(NSURL *) url ;

@end
