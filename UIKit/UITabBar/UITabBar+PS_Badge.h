//
//  UITabBar+PS_Badge.h
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * tab bar 红点
 */
@interface UITabBar (PS_Badge)

/**
 * 显示小红点
 * @param index 索引
 */
- (void) ps_showBadgeOnItemIndex:(int) index;
/**
 * 隐藏小红点
 * @param index 索引
 */
- (void) ps_hideBadgeOnItemIndex:(int) index;

/**
 * 显示数字小红点
 *
 * @param index 索引
 * @param values 值
 */
- (void) ps_showBadgeNumOnItemIndex:(int) index badgeValues:(NSInteger ) values;

/**
 * 隐藏数字小红点
 *
 * @param index 索引
 */
- (void) ps_hideNumOnItemIndex:(int) index;

@end
