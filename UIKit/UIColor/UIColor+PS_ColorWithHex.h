//
//  UIColor+PS_ColorWithHex.h
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 十六进制 颜色
 */
@interface UIColor (PS_ColorWithHex)


/**
 十六进制转颜色

 @param hex hex
 @return UIColor
 */
+ (UIColor *)ps_colorWithHex:(long)hex;

/**
 十六进制转颜色
 
 @param hex hex
 @param alpha 透明度
 @return UIColor
 */
+ (UIColor *)ps_colorWithHex:(long)hex alpha:(float)alpha ;
/**
 * 十六进制字符串 转颜色
 */
+ (UIColor *) ps_colorWithHexString:(NSString *) hexString;

/**
 * 十六进制字符串 转颜色
 */
+ (UIColor *) ps_colorWithHexString:(NSString *) hexString alpha:(CGFloat) alpha;

@end
