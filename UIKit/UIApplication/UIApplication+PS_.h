//
//  UIApplication+PS_.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/2.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (PS_)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *ps_documentsURL;
@property (nonatomic, readonly) NSString *ps_documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *ps_cachesURL;
@property (nonatomic, readonly) NSString *ps_cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *ps_libraryURL;
@property (nonatomic, readonly) NSString *ps_libraryPath;

/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *ps_appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString *ps_appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *ps_appVersion;

/// Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *ps_appBuildVersion;

/// Whether this app is pirated (not install from appstore).
@property (nonatomic, readonly) BOOL ps_isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL ps_isBeingDebugged;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float ps_cpuUsage;


/**
 Increments the number of active network requests.
 If this number was zero before incrementing, this will start animating the
 status bar network activity indicator.
 
 This method is thread safe.
 
 This method has no effect in App Extension.
 */
- (void)ps_incrementNetworkActivityCount;

/**
 减少活动网络请求的数量。
 如果该数字在递减后变为零，则停止动画
 状态栏网络活动指示器。
 
 这个方法是线程安全的。
 
 此方法在App扩展中无效。
 */
- (void)ps_decrementNetworkActivityCount;


/// Returns YES in App Extension.
+ (BOOL)ps_isAppExtension;

/// Same as sharedApplication, but returns nil in App Extension.
+ (nullable UIApplication *)ps_sharedExtensionApplication;

@end

NS_ASSUME_NONNULL_END
