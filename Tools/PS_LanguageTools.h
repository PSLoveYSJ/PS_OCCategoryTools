//
//  PS_LanguageTools.h
//  RoHas
//
//  Created by ShuaiPeng on 2017/8/17.
//  Copyright © 2017年 ShuaiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define english @"en"
#define chinese @"zh-Hans"
#define Khmer @"km"

#define PSGetStringWith(keyWords, StringFileName) [[PS_LanguageTools sharedInstance] ps_getStringForKey:keyWords withTable:StringFileName]
#define PSSetLanguage(newLanguage) [[PS_LanguageTools sharedInstance] ps_setNewLanguage:newLanguage]
#define PSChangeNowLanguage [[PS_LanguageTools sharedInstance] ps_changeNowLanguage];
#define PS_getCurrentLanguage [[PS_LanguageTools sharedInstance] ps_getCurrentLanguage]


@interface PS_LanguageTools : NSObject

+(id)sharedInstance;
/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
-(NSString *)ps_getStringForKey:(NSString *)key withTable:(NSString *)table;
/**
 *  改变当前语言
 */
-(void)ps_changeNowLanguage;
/**
 *  设置新的语言
 *
 *  @param language 新语言
 */
-(void)ps_setNewLanguage:(NSString*)language;

/**
 获取当前语言

 @return en km zh-Hans
 */
- (NSString *) ps_getCurrentLanguage;

@end
