//
//  PSTimer.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/15.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 PSTimer是基于GCD的线程安全计时器。它具有与“NSTimer”类似的API。
 PSTimer对象与NSTimer的不同之处在于:
 
 *使用GCD产生定时器，不受runLoop影响。
 *它对目标的引用较弱，因此可以避免保留循环。
 它总是在主线程上触发。
 */
@interface PSTimer : NSObject

+ (PSTimer *)ps_timerWithTimeInterval:(NSTimeInterval)interval
                            target:(id)target
                          selector:(SEL)selector
                           repeats:(BOOL)repeats;

- (instancetype)initWithFireTime:(NSTimeInterval)start
                        interval:(NSTimeInterval)interval
                          target:(id)target
                        selector:(SEL)selector
                         repeats:(BOOL)repeats NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL repeats;
@property (readonly) NSTimeInterval timeInterval;
@property (readonly, getter=isValid) BOOL valid;

- (void)invalidate;

- (void)fire;

@end

NS_ASSUME_NONNULL_END
