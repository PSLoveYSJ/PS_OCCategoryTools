//
//  NSObject+PS_SwizzleHook.m
//  PSOCStudy
//
//  Created by Peng on 2018/11/17.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "NSObject+PS_SwizzleHook.h"
#import <objc/runtime.h>

void swizzleInstanceMethod(Class cls,SEL originSelector,SEL swizzleSelector) {
    if (!cls) {
        return;
    }
    Method originMethod = class_getClassMethod(cls, originSelector);
    Method swizzleMethod = class_getClassMethod(cls, swizzleSelector);
    if (class_addMethod(cls, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod(cls, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    } else {
        class_replaceMethod(cls,
                            swizzleSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzleMethod),
                                                method_getTypeEncoding(swizzleMethod)),
                            method_getTypeEncoding(originMethod));
    }
}

void swizzleClassMethod(Class cls,SEL originSelector,SEL swizzleSelector) {
    if (!cls) {
        return;
    }
    Class metCls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    Method originMethod = class_getClassMethod(metCls, originSelector);
    Method swizzleMethod = class_getClassMethod(metCls, swizzleSelector);
    if (class_addMethod(metCls, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod(metCls, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    } else {
        class_replaceMethod(metCls,
                            swizzleSelector,
                            class_replaceMethod(metCls,
                                                originSelector,
                                                method_getImplementation(swizzleMethod),
                                                method_getTypeEncoding(swizzleMethod)),
                            method_getTypeEncoding(originMethod));
    }
}




@implementation NSObject (PS_SwizzleHook)

- (void)ps_swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector {
    swizzleClassMethod(self.class, originSelector, swizzleSelector);
}

- (void)ps_swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector {
    swizzleInstanceMethod(self.class, originSelector, swizzleSelector);
}

@end
