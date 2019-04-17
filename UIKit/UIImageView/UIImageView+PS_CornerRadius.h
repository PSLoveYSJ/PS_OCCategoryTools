//
//  UIImageView+PS_CornerRadius.h
//  PSOCStudy
//
//  Created by Peng on 2018/4/3.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (PS_CornerRadius)

/**
 * 初始化
 */
- (instancetype) ps_initWithCornerRadiusAdvance:(CGFloat) cornerRadius rectCornerType:(UIRectCorner) rectCornerType backgroundColor: (UIColor *) backgroundColor;

/**
 * 设置圆角 backGround 可传 nil
 */
- (void) ps_cornerRadiusAdvance:(CGFloat) cornerRadius rectCornerType:(UIRectCorner) rectCornerType backgroundColor: (UIColor *) backgroundColor;

- (instancetype) ps_initwithRoundImageView;
/**
 * 圆的图片
 */
- (void) ps_cornerRadiusRound;



- (instancetype) initWithFrame:(CGRect)frame radius:(CGFloat) radius image:(UIImage *) image;


@end
