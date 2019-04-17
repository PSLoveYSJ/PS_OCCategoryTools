//
//  NSObject+PSObserver.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/15.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "NSObject+PSObserver.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

//as prefix string of kvo class
static NSString * const kPSkvoClassPrefix = @"PSObserver_";
static NSString * const kPSkvoAssiociateObserver = @"PSAssiociateObserver";

#pragma mark &************* 中间类？

@interface PS_ObserverInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString * key;
@property (nonatomic, copy) PSObservingBlock observingBlock;

@end

@implementation PS_ObserverInfo

// 初始化
- (instancetype) ps_initWithObserver: (NSObject *) observer forKey:(NSString *) key observerBlock:(PSObservingBlock) observingblock {
    if (self == [super init]) {
        _observer = observer;
        self.key = key;
        self.observingBlock = observingblock;
    }
    return self;
}

@end

#pragma mark -- Transform setter or getter to each other Methods
static NSString *setterForGetter(NSString *getter) {
    if (getter.length <= 0 ) {
        return nil;
    }
    NSString * firstString = [[getter substringToIndex: 1] uppercaseString];
    NSString * leaveString = [getter substringFromIndex: 1];
    return [NSString stringWithFormat: @"set%@%@:", firstString, leaveString];
}
static NSString *getterForSetter(NSString *setter) {
    if (setter.length <= 0 || ![setter hasPrefix: @"set"] || ![setter hasSuffix: @":"]) {
        return nil;
    }
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    return getter;
}
#pragma mark -- Override setter and getter Methods
static void PSKVO_Setter(id self, SEL _cmd, id newValue) {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    if (!getterName) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat: @"unrecognized selector sent to instance %p", self] userInfo:nil];
        return;
    }
    id oldValue = [self valueForKey:getterName];
    /// Specifies the superclass of an instance. 
    struct objc_super superClass = {
            /// Specifies an instance of a class.
        .receiver = self,
        /// Specifies the particular superclass of the instance to message.
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    [self willChangeValueForKey:getterName];
    void(* objc_msgSendSuperKVO)(void *, SEL, id) = (void *)objc_msgSendSuper;
    objc_msgSendSuperKVO(&superClass,_cmd,newValue);
    [self didChangeValueForKey:getterName];
    
    // 获取所有监听回调对象进行回调
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)kPSkvoAssiociateObserver);
    for (PS_ObserverInfo * info in observers) {
        if ([info.key isEqualToString:getterName]) {
            dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                info.observingBlock(self, getterName, oldValue, newValue);
            });
        }
    }
}
static Class PS_KVO_Class(id self) {
    return class_getSuperclass(object_getClass(self));
}

#pragma mark &************** KVO reconstruct
@implementation NSObject (PSObserver)


//1. 检查对象的类有没有相应的 setter 方法。如果没有抛出异常；
//2. 检查对象 isa 指向的类是不是一个 KVO 类。如果不是，新建一个继承原来类的子类，并把 isa 指向这个新建的子类；
//检查对象的 KVO 类重写过没有这个 setter 方法。如果没有，添加重写的 setter 方法；
- (void)ps_addObserver: (NSObject *)object forKey: (NSString *)key withBlock: (PSObservingBlock)observedHandler {
    // Step 1: Throw exception if its class or superclasses doesn't implement the setter
    //修改isa指针，就是把`当前对象`指向一个`新类`
    // Person's isa ->  Person_KVO
    // Class object_setClass(id obj, Class cls)
    //使当前对象的isa指向新的派生类(Person_KVO)，就会调用派生类的set方法
    // Setter方法SEL
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"unrecognized selector sent to instance %@", self] userInfo: nil];
        return;
    }
    Class observedClass = object_getClass(self);
    NSString *className = NSStringFromClass(observedClass);
    
    // 如果被监听者没有PSObserver_ 判断需不需要新建类
    if (![className hasPrefix:kPSkvoClassPrefix]) {
        observedClass = [self ps_createKVOClassWithOriginalClassName:className];
        // 设置当前类的class
        object_setClass(self, observedClass);
    }
    
    // add kvo  setter method if its class(or superclass)hasn't implement setter
    if (![self ps_hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(observedClass, setterSelector, (IMP)PSKVO_Setter, types);
    }
    
    // add this observation info  to save new observer
    PS_ObserverInfo *newInfo = [[PS_ObserverInfo alloc] ps_initWithObserver:object forKey:key observerBlock:observedHandler];
    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge const void *)kPSkvoAssiociateObserver);
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)kPSkvoAssiociateObserver, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:newInfo];
}
// 移除监察者
- (void)ps_removeObserver:(NSObject *)observer forKey:(NSString *)key {
    NSMutableArray *obervers = objc_getAssociatedObject(self, (__bridge const void *)kPSkvoAssiociateObserver);
    PS_ObserverInfo *removeInfo = nil;
    for (PS_ObserverInfo *info in obervers) {
        if (info.observer == observer && [info.key isEqualToString:key]) {
            removeInfo = info;
            break;
        }
    }
    [obervers removeObject:removeInfo];
}


/**
 创建新的类

 @param className 原类名
 @return class
 */
- (Class)ps_createKVOClassWithOriginalClassName: (NSString *)className {
    NSString *kvoClassName = [kPSkvoClassPrefix stringByAppendingString:className];
    Class observedClass = NSClassFromString(kvoClassName);
    if (observedClass) {
        return observedClass;
    }
    // 创建新类 并且添加LXDObserver_为类名新前缀
    Class originalClass = object_getClass(self);
    Class kvoClass = objc_allocateClassPair(originalClass, kvoClassName.UTF8String, 0);
    
    // 获取监听对象的class 方法实现代码，然后替换新建的类的class 实现
    Method classMethod = class_getInstanceMethod(originalClass, @selector(class));
    const char *types = method_getTypeEncoding(classMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)PS_KVO_Class, types);
    objc_registerClassPair(kvoClass);
    return kvoClass;
}

/**
 是否包含方法

 @param selector 方法
 @return 是否包含
 */
- (BOOL)ps_hasSelector: (SEL)selector {
    Class observeredClass = object_getClass(self);
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(observeredClass, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return  NO;
}

@end
