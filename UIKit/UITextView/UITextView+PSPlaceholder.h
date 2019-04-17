//
//  UITextView+PSPlaceholder.h
//  hehe
//
//  Created by Peng on 2018/4/19.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (PSPlaceholder)

/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *ps_placeHolder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *ps_placeHolderColor;

@end
