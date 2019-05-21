//
//  PSCustomTabBar.h
//  PSOCStudy
//
//  Created by Peng on 2018/5/22.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PSCustomTabBar;

@protocol PSCustomTabBarDelegate<NSObject>

@optional

/**
 选中了哪个

 @param tabBar 自定义tabBar
 @param from 之前是哪个
 @param to 之后是哪个
 */
- (void) ps_tabBar:(PSCustomTabBar *) tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface PSCustomTabBar : UIView

- (void) ps_addTabBarButtonItem:(UITabBarItem *) item;

@property (nonatomic, weak) id<PSCustomTabBarDelegate> delegate;

@end
