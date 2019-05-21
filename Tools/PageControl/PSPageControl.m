//
//  PSPageControl.m
//  Window
//
//  Created by  王 on 2018/9/16.
//  Copyright © 2018  王. All rights reserved.
//

#import "PSPageControl.h"

#define PageWidth 12.0
#define PageInterval 4.0
#define PageHeight 2.0

@interface PSPageControl()

@end

@implementation PSPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count ; i++ ) {
        UIView *view = [self.subviews objectAtIndex:i];
        view.layer.cornerRadius = 1.0;
        view.layer.masksToBounds = YES;
        CGFloat x = PageInterval * i + PageWidth * i;
        CGFloat y = 2;
        view.frame = CGRectMake(x, y, PageWidth, PageHeight);
        if (i == self.subviews.count - 1) {
            CGFloat selfCenterX = self.center.x;
            CGFloat selfCenterY = self.center.y;
            self.frame = CGRectMake(0, 0, view.frame.origin.x + PageWidth, PageHeight + 2 * 2);
            self.center = CGPointMake(selfCenterX, selfCenterY);
        }
    }
}

@end
