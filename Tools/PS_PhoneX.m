//
//  PS_PhoneX.m
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "PS_PhoneX.h"

@implementation PS_PhoneX


+ (BOOL)isIphoneX {
    BOOL isPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return NO;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isPhoneX = YES;
        }
    }
    return isPhoneX;
}

+ (CGFloat)navBarHeight {
    if ([self isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}
+ (CGFloat)statusBarHeight {
    if ([self isIphoneX]) {
        return 44;
    } else {
        return 20;
    }
}
+ (CGFloat)tabBarHeight {
    if ([self isIphoneX]) {
        return 83;
    }
    return 49;
}

+ (CGFloat)homeindicatorHeight {
    if ([self isIphoneX]) {
        return 34.0;
    } else {
        return 0;
    }
}

@end
