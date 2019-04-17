//
//  UIDevice+PS_.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/1.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Network traffic type:
 
 WWAN: Wireless Wide Area Network.
 For example: 3G/4G.
 
 WIFI: Wi-Fi.
 
 AWDL: Apple Wireless Direct Link (peer-to-peer connection).
 For exmaple: AirDrop, AirPlay, GameKit.
 */
typedef NS_OPTIONS(NSUInteger, PSNetworkTrafficType) {
    PSNetworkTrafficTypeWWANSent     = 1 << 0,
    PSNetworkTrafficTypeWWANReceived = 1 << 1,
    PSNetworkTrafficTypeWIFISent     = 1 << 2,
    PSNetworkTrafficTypeWIFIReceived = 1 << 3,
    PSNetworkTrafficTypeAWDLSent     = 1 << 4,
    PSNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    PSNetworkTrafficTypeWWAN = PSNetworkTrafficTypeWWANSent | PSNetworkTrafficTypeWWANReceived,
    PSNetworkTrafficTypeWIFI = PSNetworkTrafficTypeWIFISent | PSNetworkTrafficTypeWIFIReceived,
    PSNetworkTrafficTypeAWDL = PSNetworkTrafficTypeAWDLSent | PSNetworkTrafficTypeAWDLReceived,
    
    PSNetworkTrafficTypeALL = PSNetworkTrafficTypeWWAN |
    PSNetworkTrafficTypeWIFI |
    PSNetworkTrafficTypeAWDL,
};

@interface UIDevice (PS_)


#pragma mark &************ device Info

/**
 获取当前版本号

 @return 版本号
 */
+ (double) ps_currentDeviceVersion;

/**
 是不是 Pad/Pad Mini
 */
@property (nonatomic, readonly) BOOL ps_isPad;

/**
 是不是模拟器
 */
@property (nonatomic, readonly) BOOL ps_isSimulator;
/// 是不是越狱系统
@property (nonatomic, readonly) BOOL ps_isJailbroken;
/// 能不能打电话
@property (nonatomic, readonly) BOOL ps_canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");
/// 手机型号 
@property (nullable, nonatomic, readonly) NSString *ps_deviceModel;
/// @see https://www.theiphonewiki.com/wiki/Models
//@property (nullable, nonatomic, readonly) NSString *ps_devideModelName;

/// 上次系统重启时间
@property (nonatomic, readonly) NSDate *ps_systemUpTime;


#pragma mark &************ Network Info

/// WIFI IP address of this device (can be nil). e.g. @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *ps_ipAddressWIFI;

/// Cell IP address of this device (can be nil). e.g. @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *ps_ipAddressCell;

/**
Get device network traffic bytes.

@discussion This is a counter since the device's last boot time.
Usage:

uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes:PSNetworkTrafficTypeALL];
NSTimeInterval time = CACurrentMediaTime();

uint64_t bytesPerSecond = (bytes - _lastBytes) / (time - _lastTime);

_lastBytes = bytes;
_lastTime = time;


@param types traffic types
@return bytes counter.
*/
- (uint64_t)ps_getNetworkTrafficBytes:(PSNetworkTrafficType)types;


#pragma mark &************ Disk Space

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_diskSpaceUsed;


#pragma mark &************  Memory Information

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ps_memoryPurgable;


#pragma mark &************ CPU Information

/// Avaliable CPU processor count.
@property (nonatomic, readonly) NSUInteger ps_cpuCount;

/// Current CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float ps_cpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *ps_cpuUsagePerProcessor;

@end

NS_ASSUME_NONNULL_END

#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif
