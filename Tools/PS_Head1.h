//
//  PS_Head1.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/8.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#ifndef PS_Head1_h
#define PS_Head1_h

#import <pthread.h>

/**
 Whether in main queue/thread.
 */
static inline bool dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

#define PS_PushXib(Controller) Controller *vc = [[Controller alloc] initWithNibName:NSStringFromClass([Controller class]) bundle:nil]; \
[self.navigationController pushViewController:vc animated:true];

#define PS_PushNotXib(Controller) Controller *vc = [[Controller alloc] init]; \
[self.navigationController pushViewController:vc animated:true];


#define PSWeakSelf         __weak __typeof(self) weakSelf = self;

/*! RGB色值 */
#define PS_COLOR(R, G, B, A)       [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#ifdef DEBUG
#define DebugLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DebugLog(...)
#endif

#define PS_Screen [UIScreen mainScreen].bounds
#define PS_Width [UIScreen mainScreen].bounds.size.width
#define PS_Height [UIScreen mainScreen].bounds.size.height

#define KeyWindow [[UIApplication sharedApplication] keyWindow]
//ios 11
#define IOS11 [[[UIDevice currentDevice] systemVersion] floatValue]>=11.0
#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0


#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#endif

#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import "PS_PrivatePermission.h"
#import "UIColor+PS_ColorWithHex.h"
#import "UIImage+_.h"
#import "UIView+PS.h"
#import "PS_PhoneX.h"
#import "NSArray+_.h"

#endif /* PS_Head1_h */
