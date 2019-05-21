//
//  PSJSONFileData.h
//  PSOCStudy
//
//  Created by Peng on 2018/5/24.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSJSONFileData : NSObject


/**
 从JSON 文件获取数组

 @param fileName 文件名
 @param arrayKey array 的key (字典下的数组)
 */
+ (NSArray *) ps_arrayWithJSONFileName:(NSString *) fileName arrayKey:(NSString *) arrayKey;
/**
 从JSON 文件获取数组
 
 @param fileName 文件名 (整一个大数组)
 */
+ (NSArray *) ps_arrayWithJSONFileName:(NSString *) fileName;
/**
 从JSON 文件获取字典
 
 @param fileName 文件名 (整一个大字典)
 */
+ (NSDictionary *) ps_dictionaryWithJSONFileName:(NSString *) fileName;

@end
