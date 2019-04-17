//
//  NSKeyedUnarchiver+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/2.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSKeyedUnarchiver (PS)

/**
 Same as unarchiveObjectWithData:, except it returns the exception by reference.
 
 @param data       The data need unarchived.
 
 @param exception  Pointer which will, upon return, if an exception occurred and
 said pointer is not NULL, point to said NSException.
 */
+ (nullable id)ps_unarchiveObjectWithData:(NSData *)data
                             exception:(NSException *_Nullable *_Nullable)exception;

/**
 Same as unarchiveObjectWithFile:, except it returns the exception by reference.
 
 @param path       The path of archived object file.
 
 @param exception  Pointer which will, upon return, if an exception occurred and
 said  pointer is not NULL, point to said NSException.
 */
+ (nullable id)ps_unarchiveObjectWithFile:(NSString *)path
                             exception:(NSException *_Nullable *_Nullable)exception;

@end

NS_ASSUME_NONNULL_END
