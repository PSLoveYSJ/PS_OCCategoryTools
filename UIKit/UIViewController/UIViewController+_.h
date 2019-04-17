//
//  UIViewController+_.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/11.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (_)



/**
 是否隐藏UINavigationController的下划线

 @param isHidden 是否隐藏
 */
- (void) ps_setHiddenNavigationBarBottomView:(BOOL) isHidden;

@end

NS_ASSUME_NONNULL_END
