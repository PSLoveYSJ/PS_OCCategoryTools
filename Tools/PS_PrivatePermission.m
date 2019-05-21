//
//  PS_PrivatePermission.m
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "PS_PrivatePermission.h"

#import "PS_Head1.h"
#import "UIWindow+PS_Hierarchy.h"
@import UIKit;
@import AVFoundation;
@import EventKit;
@import AddressBook;
@import Contacts;
@import HealthKit;
@import CoreLocation;
@import CoreTelephony;
@import Photos;


@interface PS_PrivatePermission()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) void (^finish)(BOOL success);

@end

static PS_PrivatePermission *private = nil;

@implementation PS_PrivatePermission


+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (private == nil) {
            private = [PS_PrivatePermission new];
        }
    });
    return private;
}

#pragma mark &************ 获取权限

+ (void)ps_systemPermissionAuth:(SystemPermission)permission finish:(void (^)(BOOL))finish {
    
    BOOL isSuccess = NO;
    switch (permission) {
        case SystemPermissionCamera:
            isSuccess = [self getCameraFoundation];
            break;
        case SystemPermissionCalender:
            isSuccess = [self getCalendarPermission];
            break;
        case SystemPermissionContacts:
            isSuccess = [self getContactsPermission];
            break;
        case SystemPermissionHealth:
            isSuccess = [self getHealthPermission];
            break;
        case SystemPermissionLocation:
            isSuccess = [self getLocationPermission];
            break;
        case SystemPermissionMicrophone:
            isSuccess = [self getMicrophonePermission];
            break;
        case SystemPermissionNetWork:
            isSuccess = [self getNetWorkPermission];
            break;
        case SystemPermissionPhotos:
            isSuccess = [self getPhotosPermission];
            break;
        case SystemPermissionReminders:
            isSuccess = [self getRemindersPermission];
            break;
        default:
            break;
    }
    if (finish) {
        finish(isSuccess);
    }
    
}

#pragma mark &************ 申请权限

+ (void)ps_registerSystemPermissionAuth:(SystemPermission)permission finish:(void (^)(BOOL))finish {
    switch (permission) {
        case SystemPermissionCamera:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finish) {
                        finish(granted);
                    }
                });
   
            }];
        }
            break;
        case SystemPermissionCalender:
        {
            EKEventStore * store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                if (finish) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        finish(granted);
                    });
                }
            }];
        }
             break;
        case SystemPermissionContacts:
        {
            if (@available(iOS 9.0, *)) {
                CNContactStore *store = [[CNContactStore alloc] init];
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (finish) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            finish(granted);
                        });
                    }
                }];
            } else {
                ABAddressBookRef ref = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRequestAccessWithCompletion(ref, ^(bool granted, CFErrorRef error) {
                    if (finish) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            finish(granted);
                        });
                    }
                });
            }
        }
            break;
        case SystemPermissionHealth:
        {
            if (![HKHealthStore isHealthDataAvailable]) {
                if (finish) {
                    finish(NO);
                }
            }
            NSMutableSet *readTypes = [NSMutableSet set];
            NSMutableSet *writeTypes = [NSMutableSet set];
            
            NSMutableSet *allTypes = [NSMutableSet set];
            [allTypes unionSet:readTypes];
            [allTypes unionSet:writeTypes];
            HKHealthStore *healthStore = [[HKHealthStore alloc] init];
            [healthStore requestAuthorizationToShareTypes:writeTypes
                                                readTypes:readTypes
                                               completion:^(BOOL success, NSError *error) {
                                                   if (finish) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           finish(success);
                                                       });
                                                   }
                                               }];
        }
            break;
        case SystemPermissionLocation:
        {
            if (![CLLocationManager locationServicesEnabled]) {
                if (finish) {
                    finish(NO);
                }
                return;
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                if (finish) {
                    finish(YES);
                }
            }
            if (status == kCLAuthorizationStatusNotDetermined) {
                [[PS_PrivatePermission sharedInstance] startGPS:finish];
            } else {
                if (finish) {
                    finish(NO);
                }
            }
            
            
        }
            break;
        case SystemPermissionMicrophone:
        {
            AVAudioSession *session = [[AVAudioSession alloc] init];
            NSError *error;
            [session setCategory:@"AVAudioSessionCategoryPlayAndRecord" error:&error];
            [session requestRecordPermission:^(BOOL granted) {
                if (finish) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        finish(granted);
                    });
                }
            }];
            
        }
            break;
        case SystemPermissionNetWork:
        {
            if (@available(iOS 9.0, *)) {
                CTCellularData *cellularData = [[CTCellularData alloc] init];
                cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                    if (finish) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            finish(state == kCTCellularDataNotRestricted);
                        });
                    }
                };
            } else {
                if (finish) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        finish(YES);
                    });
                }
            }
 
        }
            break;
        case SystemPermissionPhotos:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (finish) {
                    finish(status == PHAuthorizationStatusAuthorized);
                }
            }];
        }
            break;
        case SystemPermissionReminders:
        {
            EKEventStore *store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                if (finish) {
                    finish(granted);
                }
            }];
        }
        default:
            break;
    }
}

+ (void)ps_openPrivateSetting {
    if (UIApplicationOpenSettingsURLString != NULL) {
        NSURL *appSetting = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appSetting options:@{} completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:appSetting];
        }
    }
}


#pragma mark &************ 判断权限

+ (BOOL) getCameraFoundation {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启相机
            return NO;
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
            return NO;
            break;
        case AVAuthorizationStatusDenied:
            //未授权
            return NO;
            break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
            return YES;
            break;
        default:
            return NO;
            break;
    }
}


+ (BOOL) getCalendarPermission {
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    return status == EKAuthorizationStatusAuthorized;
}

+ (BOOL) getContactsPermission {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        return status == CNAuthorizationStatusAuthorized;
    } else {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        return status == kABAuthorizationStatusAuthorized;
    }
}

+ (BOOL) getHealthPermission {
    if (![HKHealthStore isHealthDataAvailable]) {
        return NO;
    }
    NSMutableSet *readTypes = [NSMutableSet set];
    NSMutableSet *writeTypes = [NSMutableSet set];
    
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSMutableSet *allTypes = [NSMutableSet set];
    [allTypes unionSet:readTypes];
    [allTypes unionSet:writeTypes];
    for (HKObjectType *sampleType in allTypes) {
        HKAuthorizationStatus status = [healthStore authorizationStatusForType:sampleType];
        return status == HKAuthorizationStatusSharingAuthorized;
    }
    return NO;
}

+ (BOOL) getLocationPermission {
    if (![CLLocationManager locationServicesEnabled]) {
        return NO;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse;
}

+ (BOOL) getMicrophonePermission {
    return [[AVAudioSession sharedInstance] recordPermission] == AVAudioSessionRecordPermissionGranted;
}

+ (BOOL) getNetWorkPermission {
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        CTCellularDataRestrictedState status = cellularData.restrictedState;
        return status == kCTCellularDataNotRestricted;
    }
    return YES;
}
+ (BOOL) getPhotosPermission {
    return [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized;
}
+ (BOOL) getRemindersPermission {
    return [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == EKAuthorizationStatusAuthorized;
}


#pragma mark &************ location delegate

- (void) startGPS:(void(^)(BOOL)) finish {
    if (self.locationManager != nil) {
        [self stopGPS];
    }
    
    self.finish = finish;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
        BOOL hasAlwaysKey = [[NSBundle mainBundle]
                             objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;
        BOOL hasWhenInUseKey =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] !=
        nil;
        if (hasAlwaysKey) {
            [self.locationManager requestAlwaysAuthorization];
        } else if (hasWhenInUseKey) {
            [self.locationManager requestWhenInUseAuthorization];
        } else {
            // At least one of the keys NSLocationAlwaysUsageDescription or
            // NSLocationWhenInUseUsageDescription MUST be present in the Info.plist
            // file to use location services on iOS 8+.
            NSAssert(hasAlwaysKey || hasWhenInUseKey,
                     @"To use location services in iOS 8+, your Info.plist must "
                     @"provide a value for either "
                     @"NSLocationWhenInUseUsageDescription or "
                     @"NSLocationAlwaysUsageDescription.");
        }
    }
    [self.locationManager startUpdatingLocation];
}

- (void) stopGPS {
    if (self.locationManager != nil) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self stopGPS];
        if (self.finish) {
            self.finish(YES);
        }
    } else if (status == kCLAuthorizationStatusNotDetermined) {
       
    } else {
        [self stopGPS];
        if (self.finish) {
            self.finish(NO);
        }
    }
}

@end


@implementation PS_PrivatePermission(PSSendMessage)

- (void)ps_sendMessagePhones:(NSArray *)phonesArray body:(NSString *)body {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phonesArray;
        controller.body = body;
        controller.messageComposeDelegate = self;
        [[UIWindow ps_getCurrentViewController] presentViewController:controller animated:YES completion:nil];
    } else {
        DebugLog(@"设备不支持短信功能");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled)
    {
        //        NSLog(@"取消发送");
    } else if (result == MessageComposeResultSent) {
        
        //        NSLog(@"已经发出");
        
    } else
    {
        //        NSLog(@"发送失败");
    }
}

@end
