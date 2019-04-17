//
//  UIButton+PSFixMultiClick.m
//  PSOCStudy
//
//  Created by Peng on 2018/12/20.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "UIButton+PSFixMultiClick.h"
#import "PSRunTime.h"

static const char *PS_ACCEPTEVENTINTERVAL = "PS_ACCEPTEVENTINTERVAL";
static const char *PS_ACCEPTEVENTEVENT = "PS_ACCEPTEVENTEVENT";

@implementation UIButton (PSFixMultiClick)

+ (void)load {
    ps_runtime_swizzleMethod([self class], @selector(sendAction:to:forEvent:), @selector(ps_sendAction:to:forEvent:));
}

- (NSTimeInterval)ps_acceptEventInterval {
   return  [objc_getAssociatedObject(self, PS_ACCEPTEVENTINTERVAL) doubleValue];
}

- (void)setPs_acceptEventInterval:(NSTimeInterval)ps_acceptEventInterval {
    objc_setAssociatedObject(self, PS_ACCEPTEVENTINTERVAL, @(ps_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)ps_acceptEventTime {
    return  [objc_getAssociatedObject(self, PS_ACCEPTEVENTEVENT) doubleValue];
}

- (void)setPs_acceptEventTime:(NSTimeInterval)ps_acceptEventTime {
    objc_setAssociatedObject(self, PS_ACCEPTEVENTEVENT, @(ps_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) ps_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.ps_acceptEventTime < self.ps_acceptEventInterval) {
        return;
    }
    if (self.ps_acceptEventInterval > 0) {
        self.ps_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self ps_sendAction:action to:target forEvent:event];
}

@end
