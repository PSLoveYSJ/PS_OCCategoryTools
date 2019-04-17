//
//  NSKeyedUnarchiver+PS.m
//  PSOCStudy
//
//  Created by Peng on 2019/1/2.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import "NSKeyedUnarchiver+PS.h"

@implementation NSKeyedUnarchiver (PS)

+ (id)ps_unarchiveObjectWithData:(NSData *)data exception:(__autoreleasing NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e)
    {
        if (exception) *exception = e;
    }
    @finally
    {
    }
    return object;
}

+ (id)ps_unarchiveObjectWithFile:(NSString *)path exception:(__autoreleasing NSException **)exception {
    id object = nil;
    
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *e)
    {
        if (exception) *exception = e;
    }
    @finally
    {
    }
    return object;
}

@end
