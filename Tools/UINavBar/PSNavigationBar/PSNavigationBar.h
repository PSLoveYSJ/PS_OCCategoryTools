

#import <UIKit/UIKit.h>
@class PSCustomNavigationBar;

@interface PSNavigationBar : UIView
+ (BOOL)isIphoneX;
+ (CGFloat)navBarBottom;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
@end


#pragma mark - Default
@interface PSNavigationBar (PSDefault)

/// 局部使用该库       待开发
//+ (void)ps_local;
/// 广泛使用该库       default 暂时是默认， ps_local 完成后，ps_local就会变成默认
+ (void)ps_widely;

/// 局部使用该库时，设置需要用到的控制器      待开发
//+ (void)ps_setWhitelist:(NSArray<NSString *> *)list;
/// 广泛使用该库时，设置需要屏蔽的控制器
+ (void)ps_setBlacklist:(NSArray<NSString *> *)list;

/** set default barTintColor of UINavigationBar */
+ (void)ps_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default barBackgroundImage of UINavigationBar */
/** warning: ps_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//+ (void)ps_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** set default tintColor of UINavigationBar */
+ (void)ps_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)ps_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)ps_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)ps_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (PSAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)ps_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)ps_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)ps_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (PSAddition)

/** record current ViewController navigationBar backgroundImage */
/** warning: ps_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)ps_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)ps_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)ps_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)ps_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)ps_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)ps_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)ps_setNavBarTintColor:(UIColor *)color;
- (UIColor *)ps_navBarTintColor;

/** record current ViewController titleColor */
- (void)ps_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)ps_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)ps_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)ps_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)ps_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)ps_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
/** warning: ps_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)ps_setCustomNavBar:(WRCustomNavigationBar *)navBar;

@end






