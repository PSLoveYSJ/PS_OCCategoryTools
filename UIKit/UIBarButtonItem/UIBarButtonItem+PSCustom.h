//
//  UIBarButtonItem+PSCustom.h
//  PSOCStudy
//
//  Created by Peng on 2018/5/22.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (PSCustom)


/**
 自定义UIButton按钮

 @param icon 图片
 @param highIcon 高亮图片
 @param target 目标
 @param action 方法
 @return UIBarButtonItem
 */
+(UIBarButtonItem *)ps_itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
