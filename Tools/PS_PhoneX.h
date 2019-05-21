//
//  PS_PhoneX.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN


/**
 iPhone X 判断
 */
@interface PS_PhoneX : NSObject

+ (BOOL) isIphoneX;

+ (CGFloat)navBarHeight;

+ (CGFloat)statusBarHeight;

+ (CGFloat)tabBarHeight;

+ (CGFloat)homeindicatorHeight;

@end

NS_ASSUME_NONNULL_END
