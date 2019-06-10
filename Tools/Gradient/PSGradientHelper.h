//
//  PSGradientHelper.h
//  PSGradientHelper
//
//  Created by Peng on 2019/6/10.
//  Copyright © 2019 PengShuai. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>


#define kDefaultWidth 200
#define kDefaultHeight 200

typedef NS_ENUM(NSInteger, PSGradientDirection) {
    PSLinearGradientDirectionLevel,                 //AC - BD
    PSLinearGradientDirectionVertical,              //AB - CD
    PSLinearGradientDirectionUpwardDiagonalLine,    //A - D
    PSLinearGradientDirectionDownDiagonalLine,      //C - B
};
//      A         B
//       _________
//      |         |
//      |         |
//       ---------
//      C         D

NS_ASSUME_NONNULL_BEGIN

@interface PSGradientHelper : NSObject

//   返回渐变色图片
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(PSGradientDirection)directionType;/* CGSizeMake(kDefaultWidth, kDefaultHeight) */
//   返回渐变色图片
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(PSGradientDirection)directionType option:(CGSize)size;

//    Radial Gradient
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor;/* raduis = kDefaultWidth / 2 */
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor option:(CGSize)size;

/**
 给View添加渐变动画

 @param view view
 */
+ (void)addGradientChromatoAnimation:(UIView *)view;

//   给label 添加渐变动画
+ (void)addLinearGradientForLableText:(UIView *)parentView lable:(UILabel *)lable start:(UIColor *)startColor and:(UIColor *)endColor;  /* don't need call 'addSubview:' for lable */
// 添加渐变动画
+ (void)addGradientChromatoAnimationForLableText:(UIView *)parentView lable:(UILabel *)lable; /* don't need call 'addSubview:' for lable */

@end

NS_ASSUME_NONNULL_END
