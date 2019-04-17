//
//  NSObject+PS_SwizzleHook.h
//  PSOCStudy
//
//  Created by Peng on 2018/11/17.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PS_SwizzleHook)

/**
 交换类方法

 @param originSelector 原始方法
 @param swizzleSelector 交换方法
 */
- (void) ps_swizzleClassMethod:(SEL) originSelector withSwizzleMethod:(SEL) swizzleSelector;

/**
 交换实例方法

 @param originSelector 原始方法
 @param swizzleSelector 交换方法
 */
- (void) ps_swizzleInstanceMethod:(SEL) originSelector withSwizzleMethod:(SEL) swizzleSelector;


@end

NS_ASSUME_NONNULL_END
