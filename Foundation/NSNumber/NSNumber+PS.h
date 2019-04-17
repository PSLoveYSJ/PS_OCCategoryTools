//
//  NSNumber+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/2.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (PS)


/**
 Creates and returns an NSNumber object from a string.
 Valid format: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 
 @param string  The string described an number.
 
 @return an NSNumber when parse succeed, or nil if an error occurs.
 */
+ (nullable NSNumber *)ps_numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
