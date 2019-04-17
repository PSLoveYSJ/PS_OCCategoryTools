//
//  NSObject+PSObserver.h
//  PSOCStudy
//
//  Created by Peng on 2018/5/15.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "PS_Head1.h"

#pragma mark -- Debug Method



typedef void(^PSObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (PSObserver)


/**
 添加属性观察者

 @param object 观察者
 @param key key
 @param observedHandler PSObservingBlock
 */
- (void)ps_addObserver: (NSObject *)object forKey: (NSString *)key withBlock: (PSObservingBlock)observedHandler;

/**
 移除观察者

 @param observer 观察者
 @param key key
 */
- (void)ps_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
