//
//  PS_PrivacyTools.m
//  PSOCStudy
//
//  Created by Peng on 2018/2/24.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PS_PrivacyTools.h"
#import <AVKit/AVKit.h>
#import <AFNetworking/AFNetworking.h>

@implementation PS_PrivacyTools


+ (BOOL)ps_isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number {
    // 初始化扫描器
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers ;
    // 判断是否有. 来设置 检查器是否包含.
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if((pointRange.length > 0) && (pointRange.location < range.location || pointRange.location > range.location + range.length)){
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    } else{
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    if ([textField.text isEqualToString:@""] && [string isEqualToString:@"."]) {
        return NO;
    }
    short remain = number;//保留number位小数
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strLen = [tempStr length];
    
    if(pointRange.length > 0 && pointRange.location > 0 ){
        //判断输入框内是否含有"."
        if([string isEqualToString:@"."]){
            return NO;//当输入框内已经含有”.“时，再输入".",则被视为无效；
        }
        if(strlen > 0 && (strLen - pointRange.location) > remain + 1){
            return NO;//当输入框内已经有”.“，当字符串长度减去小数点前面的字符串长度大于需要保留的小数点为数，则视当次输入无效。
        }
    }
    
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location ==0){
        //判断输入框第一个字符是否是”0“
    if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && !([textField.text length] ==1)){
        //当输入框只有一个字符并且字符为0时，再输入不为0或者.的字符时，则将此输入替换输入框的这唯一字符
            textField.text = string;
            return NO;
        }else{
    if(pointRange.length == 0 && pointRange.location > 0 ){
            //当输入框第一个字符为0，且没有”.“，如果当此时输入的字符为0，则视为档次输入无效；
            if([string isEqualToString:@"0"]){
                    return NO;}
        }
    }
    }
    NSString *buffer;
    if (![scanner scanCharactersFromSet:numbers intoString:&buffer] && [string length] != 0) {
        return NO;
    } else {
        return YES;
    }
}
+ (BOOL)ps_checkTel:(NSString *)telStr {
    // 方式一
//    if ([number length] == 0) {
//        return NO;
//    }
//    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:number];
//
//    if (!isMatch) {
//
//        return NO;
//    }
//
//    return YES;
    // 方式2
    if (telStr.length == 0)
    {
        return NO;
    }
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //   NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:telStr] == YES)
        || ([regextestcm evaluateWithObject:telStr] == YES)
        || ([regextestct evaluateWithObject:telStr] == YES)
        || ([regextestcu evaluateWithObject:telStr] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)ps_checkPassword:(NSString *)password {
    //        //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return YES ;
    }else
        return NO;
}

+ (BOOL) ps_checkCode:(NSString *) code {
    if ([code length]==0) {
        return NO;
    }
    NSString *regex = @"^\\d{4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:code];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
+ (BOOL)ps_checkMail:(NSString *)mail {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [pre evaluateWithObject:mail];
}
+ (BOOL)ps_checkUserName:(NSString *)userName {
    if ([userName length]==0) {
        return NO;
    }
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:userName];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
+ (BOOL)ps_checkIdentity:(NSString *)identityCard {
    //    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSString *pattern = @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:identityCard];
    return isMatch;
}
+ (CGSize)ps_boundingRectWithSize:(NSString *)txt Font:(UIFont *)font Size:(CGSize)size {
    CGSize _size;
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    
    NSStringDrawingUsesLineFragmentOrigin |
    
    NSStringDrawingUsesFontLeading;
    
    _size = [txt boundingRectWithSize:size options: options attributes:attribute context:nil].size;
    
#else
    
    _size = [txt sizeWithFont:font constrainedToSize:size];
    
#endif
    
    return _size;
}

+ (void)ps_gotoSystemSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)ps_isNetWorkingStatusBlock:(void(^)(BOOL status))block{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络");
                if (block) {
                    block(NO);
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"没网络");
                if (block) {
                    block(NO);
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"手机网络");
                if (block) {
                    block(YES);
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"wifi");
                if (block) {
                    block(YES);
                }
            }
                break;
        }
    }];
    //开始监控
    [manager startMonitoring];
}

+ (BOOL)ps_isBankCard:(NSString *)cardNumber {
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

//+ (void)updateVersion:(BOOL)showNoUpdate{
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=1307954768"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                       timeoutInterval:10];
//    [request setHTTPMethod:@"POST"];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
//        if (data) {
//            //data是有关于App所有的信息
//            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
//                [receiveStatusDic setValue:@"1" forKey:@"status"];
//                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
//                //请求的有数据，进行版本比较
//                [self receiveData:receiveStatusDic showNoUpdate:showNoUpdate];
//            }else{
//                [receiveStatusDic setValue:@"-1" forKey:@"status"];
//            }
//        }else{
//            [receiveStatusDic setValue:@"-1" forKey:@"status"];
//        }
//    }];
//
//    [task resume];
//}
//
//+ (void)receiveData:(NSDictionary *)sender showNoUpdate:(BOOL) showNoUpdate
//{
//    //获取APP自身版本号
//    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//
//    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
//    NSArray *versionArray = [sender[@"version"] componentsSeparatedByString:@"."];
//
//    NSDictionary *versionIgnore = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionIgnore];
//    if ((versionArray.count == 3) && (localArray.count == versionArray.count)) {
//        if (versionIgnore == nil) {
//            if ([localArray[0] intValue] <  [versionArray[0] intValue] ) {
//                [self updateVersionAlert:sender[@"version"]];
//            }else if ([localArray[0] intValue]  ==  [versionArray[0] intValue]){
//                if ([localArray[1] intValue] <  [versionArray[1] intValue] ) {
//                    [self updateVersionAlert:sender[@"version"]];
//                }else if ([localArray[1] intValue] ==  [versionArray[1] intValue]){
//                    if ([localArray[2] intValue] <  [versionArray[2] intValue]) {
//                        [self updateVersionAlert:sender[@"version"]];
//                    } else {
//                        if (showNoUpdate) {
//                            [AlertTools alertWithNoCanceltitle:nil message:@"最新版本！" titles:@[@"好的"] clickBlock:nil];
//                        }
//                    }
//                }
//            }
//        } else {
//            if (![[versionIgnore objectForKey:kVersionIgnore] isEqualToString:sender[@"version"]]) {
//                if ([localArray[0] intValue] <  [versionArray[0] intValue] ) {
//                    [self updateVersionAlert:sender[@"version"]];
//                }else if ([localArray[0] intValue]  ==  [versionArray[0] intValue]){
//                    if ([localArray[1] intValue] <  [versionArray[1] intValue] ) {
//                        [self updateVersionAlert:sender[@"version"]];
//                    }else if ([localArray[1] intValue] ==  [versionArray[1] intValue]){
//                        if ([localArray[2] intValue] <  [versionArray[2] intValue]) {
//                            [self updateVersionAlert:sender[@"version"]];
//                        } else {
//                            if (showNoUpdate) {
//                                [AlertTools alertWithNoCanceltitle:nil message:@"最新版本！" titles:@[@"好的"] clickBlock:nil];
//                            }
//                        }
//                    }
//                }
//            } else {
//                if (showNoUpdate) {
//                    [AlertTools alertWithNoCanceltitle:nil message:@"最新版本！" titles:@[@"好的"] clickBlock:nil];
//                }
//            }
//        }
//    }
//}
//
//+ (void)updateVersionAlert:(NSString *) leastVersion {
//
//    NSString *msg = [NSString stringWithFormat:@"获取最新版本，优惠信息提前知"];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"重要提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"下载新版本"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/%%E5%%A1%%91%%E7%%BE%%8E/id1307954768?mt=8"]];
//        [[UIApplication sharedApplication]openURL:url];
//    }];
//    UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"忽略此版本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSDictionary *ignoreDic = @{kVersionIgnore:leastVersion};
//        [[NSUserDefaults standardUserDefaults] setObject:ignoreDic forKey:kVersionIgnore];
//    }];
//    UIAlertAction *downAction = [UIAlertAction actionWithTitle:@"暂不下载" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:ignoreAction];
//    [alertController addAction:otherAction];
//    [alertController addAction:downAction];
//    [[self getCurrentViewController]  presentViewController:alertController animated:YES completion:nil];
//
//}


@end
