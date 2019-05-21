//
//  PS_PrivacyTools.h
//  PSOCStudy
//
//  Created by Peng on 2018/2/24.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface PS_PrivacyTools : NSObject
    

/**
 * 设置输入框只能输入数字 和小数，且小数点 只能有一位 number 小数点位数 需配合TextFieldDelegate 使用
 */
+ (BOOL) ps_isValidAboutInputText:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger )number;
/**
 * 检测是否手机号
 */
+ (BOOL) ps_checkTel:(NSString *) tel;
/**
 * 检查是否是密码
 */
+ (BOOL) ps_checkPassword:(NSString *) password;
/**
 * 检查验证码
 */
+ (BOOL) ps_checkCode:(NSString *) code;
/**
 * 检查是否是邮箱
 */
+ (BOOL) ps_checkMail:(NSString *) mail;
/**
 * 检查用户名
 */
+ (BOOL) ps_checkUserName:(NSString *) userName;
/**
 * 检查身份证号
 */
+ (BOOL) ps_checkIdentity:(NSString *) identityCard;

/**
 计算字体宽高
 
 @param txt <#txt description#>
 @param font <#font description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (CGSize)ps_boundingRectWithSize:(NSString*) txt Font:(UIFont*) font Size:(CGSize) size;

/**
 跳转系统设置界面
 */
+ (void)ps_gotoSystemSetting;

/**
 * 检测网络
 */
+ (void)ps_isNetWorkingStatusBlock:(void(^)(BOOL status))block;

/**
 * 是否是银行卡
 */
+ (BOOL)ps_isBankCard:(NSString *)cardNumber;



@end
