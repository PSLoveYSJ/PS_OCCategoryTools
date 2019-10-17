//
//  UIColor+PS.m
//  PSOCStudy
//
//  Created by Peng on 2019/1/2.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import "UIColor+PS.h"

@implementation UIColor (PS)


+ (UIColor *)ps_randomColor {
    return [UIColor colorWithRed:(arc4random() % 255 + 1) / 255.0
                           green:(arc4random() % 255 + 1) / 255.0
                            blue:(arc4random() % 255 + 1) / 255.0
                           alpha:1];
}

@end
