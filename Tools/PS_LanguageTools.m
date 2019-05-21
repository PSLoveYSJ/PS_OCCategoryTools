//
//  PS_LanguageTools.m
//  RoHas
//
//  Created by ShuaiPeng on 2017/8/17.
//  Copyright © 2017年 ShuaiPeng. All rights reserved.
//

#import "PS_LanguageTools.h"

#define Language_set @"Language_set"

@interface PS_LanguageTools()

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, copy) NSString *language;

@property (nonatomic, strong) NSMutableDictionary *languageDic;

@end

@implementation PS_LanguageTools

+ (id)sharedInstance {
    static id tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}
- (instancetype)init {
    if (self = [super init]) {
        [self initLanguage];
    }
    return self;
}
- (void) initLanguage {
    NSString *tmp = [[NSUserDefaults standardUserDefaults]objectForKey:Language_set];
    NSString *path;
    //默认是中文
    if (!tmp)
    {
        tmp = english;
    }
    
    self.language = tmp;
    [[NSUserDefaults standardUserDefaults]setObject:tmp forKey:Language_set];
    [[NSUserDefaults standardUserDefaults]synchronize];
    path = [[NSBundle mainBundle]pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}
- (NSString *)ps_getStringForKey:(NSString *)key withTable:(NSString *)table {
    if (self.bundle) {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, nil);
    }
    return NSLocalizedStringFromTable(key, table, nil);
}
- (void)ps_changeNowLanguage {
    [self ps_setNewLanguage:self.language];
}
- (void)ps_setNewLanguage:(NSString *)language {
    if ([language isEqualToString:self.language]) {
        return;
    }
    if ([language isEqualToString:english] ||[language isEqualToString:Khmer]|| [language isEqualToString:chinese])  {
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    self.language = language;
    [[NSUserDefaults standardUserDefaults]setObject:language forKey:Language_set];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
}
- (NSString *)ps_getCurrentLanguage {
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:Language_set];
    return [self.languageDic objectForKey:string];
}
//[NSMutableArray arrayWithObjects:@"English",@"ភាសាខ្មែរ",@"简体中文", nil];
//#define english @"en"
//#define chinese @"zh-Hans"
//#define Khmer @"km"
#pragma mark --// property
- (NSMutableDictionary *)languageDic {
    if (!_languageDic) {
         _languageDic = [NSMutableDictionary dictionary];
        [_languageDic setObject:@"English" forKey:english];
        [_languageDic setObject:@"ភាសាខ្មែរ" forKey:Khmer];
        [_languageDic setObject:@"简体中文" forKey:chinese];
    }
    return _languageDic;
}

@end
