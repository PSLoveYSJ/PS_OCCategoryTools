//
//  PS_PrivatePermission.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>



@import Messages;
@import MessageUI;

typedef NS_ENUM(NSInteger, SystemPermission) {
    SystemPermissionCamera, // 相机
    SystemPermissionCalender, // 日历
    SystemPermissionContacts, // 联系人
    SystemPermissionHealth, // 健康
    SystemPermissionLocation, // 位置
    SystemPermissionMicrophone, // 麦克风
    SystemPermissionNetWork, // 网络
    SystemPermissionPhotos, // 图片
    SystemPermissionReminders // 提醒
} ;

NS_ASSUME_NONNULL_BEGIN

@interface PS_PrivatePermission : NSObject

+ (instancetype) sharedInstance;


/**
 获取手机权限

 @param permission 权限
 @param finish 结束
 */
+ (void) ps_systemPermissionAuth:(SystemPermission) permission finish:(void(^)(BOOL isSuccess)) finish;


/**
 申请手机权限

 @param permission 权限
 @param finish 完成
 */
+ (void) ps_registerSystemPermissionAuth:(SystemPermission) permission finish:(void(^)(BOOL isSuccess)) finish;


/**
 打开App设置界面
 */
+ (void) ps_openPrivateSetting;


@end


#pragma mark &************ 发送短消息

@interface PS_PrivatePermission(PSSendMessage)<MFMessageComposeViewControllerDelegate>

- (void) ps_sendMessagePhones:(NSArray *) phonesArray body:(NSString *) body;

@end

NS_ASSUME_NONNULL_END
