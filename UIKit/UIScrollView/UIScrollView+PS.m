//
//  UIScrollView+PS.m
//  PSOCStudy
//
//  Created by Peng on 2019/1/9.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import "UIScrollView+PS.h"

@implementation UIScrollView (PS)

- (void)ps_scrollToTop {
    [self ps_scrollToTopAnimated:YES];
}

- (void)ps_scrollToBottom {
    [self ps_scrollToBottomAnimated:YES];
}

- (void)ps_scrollToLeft {
    [self ps_scrollToLeftAnimated:YES];
}

- (void)ps_scrollToRight {
    [self ps_scrollToRightAnimated:YES];
}

- (void)ps_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)ps_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)ps_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)ps_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}


@end
