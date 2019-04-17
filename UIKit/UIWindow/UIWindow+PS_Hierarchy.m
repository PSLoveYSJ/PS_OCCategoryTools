//
//  UIWindow+PS_Hierarchy.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UIWindow+PS_Hierarchy.h"

@implementation UIWindow (PS_Hierarchy)


+ (UIViewController *) ps_getCurrentViewController {
    UIViewController *vc = nil;
    vc = [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    while (vc.presentedViewController != nil) {
        vc = [self topViewController:vc.presentedViewController];
    }
    return vc;
}
+ (UIViewController *) topViewController:(UIViewController *) vc  {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}

@end
