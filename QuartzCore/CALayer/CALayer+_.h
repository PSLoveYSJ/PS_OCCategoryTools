//
//  CALayer+_.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (_)

/**
 Take snapshot without transform, image's size equals to bounds.
 */
- (nullable UIImage *)ps_snapshotImage;

/**
 Take snapshot without transform, PDF's page size equals to bounds.
 */
- (nullable NSData *)ps_snapshotPDF;

/**
 Shortcut to set the layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)ps_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all sublayers.
 */
- (void)ps_removeAllSublayers;

/**
 Wrapper for `contentsGravity` property. // 属性包装器
 */
@property (nonatomic) UIViewContentMode ps_contentMode;


@end

@interface CALayer (Frame)

@property (nonatomic, assign) CGFloat ps_x;
@property (nonatomic, assign) CGFloat ps_y;
@property (nonatomic, assign) CGFloat ps_width;
@property (nonatomic, assign) CGFloat ps_height;

@property (nonatomic, assign, readonly) CGFloat ps_right;
@property (nonatomic, assign, readonly) CGFloat ps_bottom;

@property (nonatomic, assign) CGPoint ps_origin;
@property (nonatomic, assign) CGSize  ps_size;

@end



NS_ASSUME_NONNULL_END
