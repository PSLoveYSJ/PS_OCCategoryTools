//
//  PSThreadSafeArray.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/15.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A simple implementation of thread safe mutable array.
 
 @discussion Generally, access performance is lower than NSMutableArray,
 but higher than using @synchronized, NSLock, or pthread_mutex_t.
 
 @discussion It's also compatible with the custom methods in `NSArray(PSAdd)`
 and `NSMutableArray(PSAdd)`
 
 @warning Fast enumerate(for..in) and enumerator is not thread safe,
 use enumerate using block instead. When enumerate or sort with block/callback,
 do *NOT* send message to the array inside the block/callback.
 */
@interface PSThreadSafeArray : NSMutableArray

@end

NS_ASSUME_NONNULL_END
