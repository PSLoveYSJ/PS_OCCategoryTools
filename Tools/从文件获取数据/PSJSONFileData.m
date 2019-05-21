//
//  PSJSONFileData.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/24.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSJSONFileData.h"

@implementation PSJSONFileData

+ (NSArray *)ps_arrayWithJSONFileName:(NSString *)fileName {
    NSData *data = [self fileDataWithFilename:fileName];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
  return array;
}
+ (NSArray *)ps_arrayWithJSONFileName:(NSString *)fileName arrayKey:(NSString *)arrayKey {
    NSData *data = [self fileDataWithFilename:fileName];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dic[arrayKey];
}
+ (NSDictionary *)ps_dictionaryWithJSONFileName:(NSString *)fileName {
    NSData *data = [self fileDataWithFilename:fileName];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}
+ (NSData *) fileDataWithFilename:(NSString *) fileName {
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    return data;
}

@end
