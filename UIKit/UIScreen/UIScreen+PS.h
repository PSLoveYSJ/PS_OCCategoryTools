//
//  UIScreen+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/9.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (PS)

/**
 Main screen's scale
 
 @return screen's scale
 */
+ (CGFloat)ps_screenScale;

/**
 Returns the bounds of the screen for the current device orientation.
 
 @return A rect indicating the bounds of the screen.
 @see    boundsForOrientation:
 */
- (CGRect)ps_currentBounds NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 Returns the bounds of the screen for a given device orientation.
 `UIScreen`'s `bounds` method always returns the bounds of the
 screen of it in the portrait orientation.
 
 @param orientation  The orientation to get the screen's bounds.
 @return A rect indicating the bounds of the screen.
 @see  currentBounds
 */
- (CGRect)ps_boundsForOrientation:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
