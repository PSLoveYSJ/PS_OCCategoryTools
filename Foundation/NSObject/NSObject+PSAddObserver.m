//
//  NSObject+PSAddObserver.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/25.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "NSObject+PSAddObserver.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark - 私有实现KVO的真实target类，每一个target对应了一个keyPath和监听该keyPath的所有block，当其KVO方法调用时，需要回调所有的block

@interface _PSBlockTarget : NSObject

/**添加一个KVOBlock*/
- (void)ps_addBlock:(void(^)(__weak id obj, id oldValue, id newValue))block;

/**
  添加一个notification block
 */
- (void)ps_addNotificationBlock:(void(^)(NSNotification *notification))block;

- (void)ps_doNotification:(NSNotification*)notification;

@end

@implementation _PSBlockTarget {
    NSMutableSet *_kvoBlockSet;
    NSMutableSet *_notificationBlockSet;
}

- (instancetype)init {
    if (self == [super init]) {
        _kvoBlockSet = [NSMutableSet new];
        _notificationBlockSet = [NSMutableSet new];
    }
    return self;
}
-(void)ps_addBlock:(void (^)(__weak id obj, id oldValue, id newValue))block {
    [_kvoBlockSet addObject:[block copy]];
}
- (void)ps_addNotificationBlock:(void (^)(NSNotification *))block {
    [_notificationBlockSet addObject:[block copy]];
}
-(void)ps_doNotification:(NSNotification *)notification {
    if (!_notificationBlockSet.count) {
        return;
    }
    [_notificationBlockSet enumerateObjectsUsingBlock:^(void (^block)(NSNotification  * notification), BOOL * _Nonnull stop) {
        block(notification);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!_kvoBlockSet.count) return;
    BOOL prior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    //只接受值改变时的消息
    if (prior) return;
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    //执行该target下的所有block
    [_kvoBlockSet enumerateObjectsUsingBlock:^(void (^block)(__weak id obj, id oldVal, id newVal), BOOL * _Nonnull stop) {
        block(object, oldVal, newVal);
    }];
}


@end


@implementation NSObject (PSAddObserver)

static void *const PSKVOBlockKey = "PSKVOBlockKey";
static void *const PSKVOSemaphoreKey = "PSKVOSemaphoreKey";

- (void)ps_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id, id, id))block {
    if (!keyPath || !block) return;
    dispatch_semaphore_t kvoSemaphore = [self _ps_getSemaphoreWithKey:PSKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    //取出存有所有KVOTarget的字典
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, PSKVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets = [NSMutableDictionary new];
        //绑定在该对象中
        objc_setAssociatedObject(self, PSKVOBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //获取对应keyPath中的所有target
    _PSBlockTarget *targetForKeyPath = allTargets[keyPath];
    if (!targetForKeyPath) {
        //没有则创建
        targetForKeyPath = [_PSBlockTarget new];
        //保存
        allTargets[keyPath] = targetForKeyPath;
        //如果第一次，则注册对keyPath的KVO监听
        [self addObserver:targetForKeyPath forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    [targetForKeyPath ps_addBlock:block];
    //对第一次注册KVO的类进行dealloc方法调剂
    [self _ps_swizzleDealloc];
    dispatch_semaphore_signal(kvoSemaphore);
}

- (void)ps_removeObserverBlockForKeyPath:(NSString *)keyPath {
    if (!keyPath.length) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, PSKVOBlockKey);
    if (!allTargets) return;
    _PSBlockTarget *target = allTargets[keyPath];
    if (!target) return;
    dispatch_semaphore_t kvoSemaphore = [self _ps_getSemaphoreWithKey:PSKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
    dispatch_semaphore_signal(kvoSemaphore);
}
- (void)ps_removeAllObserverBlocks {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, PSKVOBlockKey);
    if (!allTargets) return;
    dispatch_semaphore_t kvoSemaphore = [self _ps_getSemaphoreWithKey:PSKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id key, _PSBlockTarget *target, BOOL *stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(kvoSemaphore);
}

static void * const PSNotificationBlockKey = "PSNotificationBlockKey";
static void * const PSNotificationSemaphoreKey = "PSNotificationSemaphoreKey";


- (dispatch_semaphore_t)_ps_getSemaphoreWithKey:(void *)key {
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key);
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(1);
        objc_setAssociatedObject(self, key, semaphore, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return semaphore;
}
- (void)ps_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *))block {
    if (!name || !block) return;
    dispatch_semaphore_t notificationSemaphore = [self _ps_getSemaphoreWithKey:PSNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, PSNotificationBlockKey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, PSNotificationBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    _PSBlockTarget *target = allTargets[name];
    if (!target) {
        target = [_PSBlockTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(ps_doNotification:) name:name object:nil];
    }
    [target ps_addNotificationBlock:block];
    [self _ps_swizzleDealloc];
    dispatch_semaphore_signal(notificationSemaphore);
}
- (void)ps_removeNotificationForName:(NSString *)name {
    if (!name) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, PSNotificationBlockKey);
    if (!allTargets.count) return;
    _PSBlockTarget *target = allTargets[name];
    if (!target) return;
    dispatch_semaphore_t notificationSemaphore = [self _ps_getSemaphoreWithKey:PSNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [[NSNotificationCenter defaultCenter] removeObserver:target];
    [allTargets removeObjectForKey:name];
    dispatch_semaphore_signal(notificationSemaphore);
}
- (void)ps_removeAllNotification {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, PSNotificationBlockKey);
    if (!allTargets.count) return;
    dispatch_semaphore_t notificationSemaphore = [self _ps_getSemaphoreWithKey:PSNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, _PSBlockTarget *target, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:target];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(notificationSemaphore);
}
- (void)ps_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}

static void *deallocHasSwizzledKey = "deallocHasSwizzledKey";

/**
 *  调剂dealloc方法，由于无法直接使用运行时的swizzle方法对dealloc方法进行调剂，所以稍微麻烦一些
 */
- (void) _ps_swizzleDealloc {
    //我们给每个类绑定上一个值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, deallocHasSwizzledKey) boolValue];
    //如果调剂过则直接返回
    if (swizzled) return;
    //开始调剂
    Class swizzleClass = self.class;
    @synchronized(swizzleClass) {
        //获取原有的dealloc方法
        SEL deallocSelector = sel_registerName("dealloc");
        //初始化一个函数指针用于保存原有的dealloc方法
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        //实现我们自己的dealloc方法，通过block的方式
        id newDealloc = ^(__unsafe_unretained id objSelf){
            //在这里我们移除所有的KVO
            [objSelf ps_removeAllObserverBlocks];
            //移除所有通知
            [objSelf ps_removeAllNotification];
            //根据原有的dealloc方法是否存在进行判断
            if (originalDealloc == NULL) {//如果不存在，说明本类没有实现dealloc方法，则需要向父类发送dealloc消息(objc_msgSendSuper)
                //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
                struct objc_super superInfo = {
                    .receiver = objSelf,
                    .super_class = class_getSuperclass(swizzleClass)
                };
                //构建objc_msgSendSuper函数
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                //向super发送dealloc消息
                msgSend(&superInfo, deallocSelector);
            }else{//如果存在，表明该类实现了dealloc方法，则直接调用即可
                //调用原有的dealloc方法
                originalDealloc(objSelf, deallocSelector);
            }
        };
        //根据block构建新的dealloc实现IMP
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        //尝试添加新的dealloc方法，如果该类已经复写的dealloc方法则不能添加成功，反之则能够添加成功
        if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
            //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
            Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        //标记该类已经调剂过了
        objc_setAssociatedObject(self.class, deallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
