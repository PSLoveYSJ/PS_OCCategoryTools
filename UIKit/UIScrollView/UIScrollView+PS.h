//
//  UIScrollView+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/9.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (PS)

/**
 Scroll content to top with animation.
 */
- (void)ps_scrollToTop;

/**
 Scroll content to bottom with animation.
 */
- (void)ps_scrollToBottom;

/**
 Scroll content to left with animation.
 */
- (void)ps_scrollToLeft;

/**
 Scroll content to right with animation.
 */
- (void)ps_scrollToRight;

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)ps_scrollToTopAnimated:(BOOL)animated;

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)ps_scrollToBottomAnimated:(BOOL)animated;

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)ps_scrollToLeftAnimated:(BOOL)animated;

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)ps_scrollToRightAnimated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
