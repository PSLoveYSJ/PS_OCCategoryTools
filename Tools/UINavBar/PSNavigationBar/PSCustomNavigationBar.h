#import <UIKit/UIKit.h>

@interface PSCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)ps_setBottomLineHidden:(BOOL)hidden;
- (void)ps_setBackgroundAlpha:(CGFloat)alpha;
- (void)ps_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)ps_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)ps_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)ps_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)ps_setLeftButtonWithImage:(UIImage *)image;
- (void)ps_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)ps_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)ps_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)ps_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)ps_setRightButtonWithImage:(UIImage *)image;
- (void)ps_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;



@end













