//
//  UIViewController+_.m
//  PSOCStudy
//
//  Created by Peng on 2018/10/11.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "UIViewController+_.h"

@implementation UIViewController (_)

- (void)ps_setHiddenNavigationBarBottomView:(BOOL)isHidden {
    if (self.navigationController != nil) {
        UIImageView *imv = [self findNavigationBarBottomView:self.navigationController.navigationBar];
        imv.hidden = isHidden;
    } else {
        
    }
}

- (UIImageView *) findNavigationBarBottomView:(UIView *) view {
    if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height <= 1) {
        return (UIImageView *) view;
    }
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self findNavigationBarBottomView:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
