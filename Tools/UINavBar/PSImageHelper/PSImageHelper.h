

#import <UIKit/UIKit.h>

@interface UIImage (PSHelper)

-(UIImage *)ps_updateImageWithTintColor:(UIColor*)color;
-(UIImage *)ps_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha;
-(UIImage *)ps_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage *)ps_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage *)ps_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage *)ps_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect;

@end
