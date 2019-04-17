//
//  PSRunTime.h
//  PSOCStudy
//
//  Created by Peng on 2018/5/16.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "PS_Head1.h"

#pragma mark &*************** 返回一个对象的class



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
//代码段




/**
 返回一个object对 class

 @param obj objcect
 @return class
 */
static Class ps_runtime_getClassWith(id obj) {
    return object_getClass(obj);
}
#pragma mark &*************** 交换方法
//class_addMethod 。要先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
/**
 交换方法
 
 @param class class
 @param originalSelector originalSelector
 @param swizzledSelector swizzledSelector
 */
static void ps_runtime_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod); }
}

#pragma mark &*************** 获取class 的类方法
/**
 获取类方法名字 集合
 
 @param class 类
 @return 返回数组
 */
static NSArray *ps_runtime_getClassMethodsName(Class class) {
    NSMutableArray *methodsArray = [NSMutableArray array];
    unsigned methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    
    for (int i = 0; i < methodCount; i++) {
        [methodsArray addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    return methodsArray;
}
#pragma mark &**************** 获取所有已经注册的类的方法
/**
 获取系统已经注册的所有类
 
 @return array
 */
static NSArray *ps_runtime_getAllRegisterClassNameWith_ObjcGetClassList(){
    int count = 0;
    int totalCount = objc_getClassList(NULL, 0);// 传NULL 返回所有的注册的类的方法
    Class *classes = NULL;
    NSMutableArray *array = [NSMutableArray array];
    while (count < totalCount) {
        count = totalCount;
        classes =(Class *) realloc(classes, sizeof(Class) * count);
        totalCount = objc_getClassList(classes, count);
        for (int i = 0; i < totalCount; i++) {
            const char *className = class_getName(classes[i]);
            NSString *string = [[NSString alloc] initWithUTF8String:className];
            [array addObject:string];
        }
    }
    free(classes);
    return array;
}

/**
 获取系统已经注册的所有类

 @return array
 */
static NSArray *ps_runtime_getAllRegisterClassNameWith_objc_copyClassList() {
    unsigned int count = 0;
    NSMutableArray *array = [NSMutableArray array];
    Class *classes = objc_copyClassList(&count);
    for (int i = 0; i < count; i++) {
        const char *className = class_getName(classes[i]);
        [array addObject:[[NSString alloc] initWithUTF8String:className]];
    }
    free(classes);
    return  array;
}

@interface PSRunTime : NSObject

- (void) ps_getMethod;
- (void) ps_hehe;

@end


#pragma clang diagnostic pop
