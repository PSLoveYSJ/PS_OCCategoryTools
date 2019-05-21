//
//  PSReachability.m
//  PSOCStudy
//
//  Created by Peng on 2019/1/15.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import "PSReachability.h"
#import <objc/message.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static PSReachabilityStatus PSReachabilityStatusFromFlags(SCNetworkReachabilityFlags flags, BOOL allowWWAN) {
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
        return PSReachabilityStatusNone;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) &&
        (flags & kSCNetworkReachabilityFlagsTransientConnection)) {
        return PSReachabilityStatusNone;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) && allowWWAN) {
        return PSReachabilityStatusWWAN;
    }
    
    return PSReachabilityStatusWiFi;
}

static void PSReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info) {
    PSReachability *self = ((__bridge PSReachability *)info);
    if (self.notifyBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.notifyBlock(self);
        });
    }
}

@interface PSReachability ()
@property (nonatomic, assign) SCNetworkReachabilityRef ref;
@property (nonatomic, assign) BOOL scheduled;
@property (nonatomic, assign) BOOL allowWWAN;
@property (nonatomic, strong) CTTelephonyNetworkInfo *networkInfo;
@end

@implementation PSReachability

+ (dispatch_queue_t)sharedQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.ibireme.PSkit.reachability", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

- (instancetype)init {
    /*
     See Apple's Reachability implementation and readme:
     The address 0.0.0.0, which reachability treats as a special token that
     causes it to actually monitor the general routing status of the device,
     both IPv4 and IPv6.
     https://developer.apple.com/library/ios/samplecode/Reachability/Listings/ReadMe_md.html#//apple_ref/doc/uid/DTS40007324-ReadMe_md-DontLinkElementID_11
     */
    struct sockaddr_in zero_addr;
    bzero(&zero_addr, sizeof(zero_addr));
    zero_addr.sin_len = sizeof(zero_addr);
    zero_addr.sin_family = AF_INET;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zero_addr);
    return [self initWithRef:ref];
}

- (instancetype)initWithRef:(SCNetworkReachabilityRef)ref {
    if (!ref) return nil;
    self = super.init;
    if (!self) return nil;
    _ref = ref;
    _allowWWAN = YES;
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        _networkInfo = [CTTelephonyNetworkInfo new];
    }
    return self;
}

- (void)dealloc {
    self.notifyBlock = nil;
    self.scheduled = NO;
    CFRelease(self.ref);
}

- (void)setScheduled:(BOOL)scheduled {
    if (_scheduled == scheduled) return;
    _scheduled = scheduled;
    if (scheduled) {
        SCNetworkReachabilityContext context = { 0, (__bridge void *)self, NULL, NULL, NULL };
        SCNetworkReachabilitySetCallback(self.ref, PSReachabilityCallback, &context);
        SCNetworkReachabilitySetDispatchQueue(self.ref, [self.class sharedQueue]);
    } else {
        SCNetworkReachabilitySetDispatchQueue(self.ref, NULL);
    }
}

- (SCNetworkReachabilityFlags)flags {
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityGetFlags(self.ref, &flags);
    return flags;
}

- (PSReachabilityStatus)status {
    return PSReachabilityStatusFromFlags(self.flags, self.allowWWAN);
}

- (PSReachabilityWWANStatus)wwanStatus {
    if (!self.networkInfo) return PSReachabilityWWANStatusNone;
    NSString *status = self.networkInfo.currentRadioAccessTechnology;
    if (!status) return PSReachabilityWWANStatusNone;
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{CTRadioAccessTechnologyGPRS : @(PSReachabilityWWANStatus2G),  // 2.5G   171Kbps
                CTRadioAccessTechnologyEdge : @(PSReachabilityWWANStatus2G),  // 2.75G  384Kbps
                CTRadioAccessTechnologyWCDMA : @(PSReachabilityWWANStatus3G), // 3G     3.6Mbps/384Kbps
                CTRadioAccessTechnologyHSDPA : @(PSReachabilityWWANStatus3G), // 3.5G   14.4Mbps/384Kbps
                CTRadioAccessTechnologyHSUPA : @(PSReachabilityWWANStatus3G), // 3.75G  14.4Mbps/5.76Mbps
                CTRadioAccessTechnologyCDMA1x : @(PSReachabilityWWANStatus3G), // 2.5G
                CTRadioAccessTechnologyCDMAEVDORev0 : @(PSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyCDMAEVDORevA : @(PSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyCDMAEVDORevB : @(PSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyeHRPD : @(PSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyLTE : @(PSReachabilityWWANStatus4G)}; // LTE:3.9G 150M/75M  LTE-Advanced:4G 300M/150M
    });
    NSNumber *num = dic[status];
    if (num != nil) return num.unsignedIntegerValue;
    else return PSReachabilityWWANStatusNone;
}

- (BOOL)isReachable {
    return self.status != PSReachabilityStatusNone;
}

+ (instancetype)reachability {
    return self.new;
}

+ (instancetype)reachabilityForLocalWifi {
    struct sockaddr_in localWifiAddress;
    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len = sizeof(localWifiAddress);
    localWifiAddress.sin_family = AF_INET;
    localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    PSReachability *one = [self reachabilityWithAddress:(const struct sockaddr *)&localWifiAddress];
    one.allowWWAN = NO;
    return one;
}

+ (instancetype)reachabilityWithHostname:(NSString *)hostname {
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    return [[self alloc] initWithRef:ref];
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress {
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)hostAddress);
    return [[self alloc] initWithRef:ref];
}

- (void)setNotifyBlock:(void (^)(PSReachability *reachability))notifyBlock {
    _notifyBlock = [notifyBlock copy];
    self.scheduled = (self.notifyBlock != nil);
}

@end
