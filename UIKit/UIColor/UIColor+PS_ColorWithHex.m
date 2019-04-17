//
//  UIColor+PS_ColorWithHex.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UIColor+PS_ColorWithHex.h"

@implementation UIColor (PS_ColorWithHex)

+ (UIColor *)ps_colorWithHex:(long)hex {
    return [UIColor ps_colorWithHex:hex alpha:1];
}
+ (UIColor *)ps_colorWithHex:(long)hex alpha:(float)alpha {
    if (hex > 0xFFFFFF) {
        return [UIColor whiteColor];
    }
    float red = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hex & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ps_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    //    r
    NSString * rString = [cString substringWithRange:range];
    //    g
    range.location = 2;
    NSString * gString = [cString substringWithRange:range];
    //    b
    range.location = 4;
    NSString * bString = [cString substringWithRange:range];
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
//    //method1
//    NSScanner *scanner = [NSScanner scannerWithString:hexString];
//    unsigned int hexNumber;
//    if (![scanner scanHexInt:&hexNumber])
//        return defaultColor;
//
//    //method2
//    const char *char_str = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
//    int hexNum;
//    sscanf(char_str, "%x", &hexNum);
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
}


+ (UIColor *)ps_colorWithHexString:(NSString *)hexString  {
   return [self ps_colorWithHexString:hexString alpha:1.0f];
}

@end
