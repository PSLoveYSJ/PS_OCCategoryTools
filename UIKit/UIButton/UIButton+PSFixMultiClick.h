//
//  UIButton+PSFixMultiClick.h
//  PSOCStudy
//
//  Created by Peng on 2018/12/20.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 防止重复点击
 */
@interface UIButton (PSFixMultiClick)


/**
 重复点击间隔
 */
@property (nonatomic, assign) NSTimeInterval ps_acceptEventInterval;

/**
 
 */
@property (nonatomic, assign) NSTimeInterval ps_acceptEventTime;

@end

NS_ASSUME_NONNULL_END
