//
//  UIImage+_.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (_)

/**
 获取更小的图片
 @return 图片
 */
- (UIImage *)ps_zipNSDataWithImage;

/**
 返回不大于屏幕尺寸的图片

 @param image 原始图片
 @return 新生成图片
 */
+ (UIImage *)ps_imageSizeWithScreenImage:(UIImage *)image;

/**
 生成颜色图片

 @param color 颜色
 @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;


+(UIImage *)drawImagesize:(CGSize)size
          backgroundColor:(UIColor *)backgroundColor
          imageProportion:(CGFloat)proportion;


@end

#pragma mark &************ radius 

@interface UIImage(Radius)

/**
 生成圆形图片

 @return
 */
- (instancetype)circleImage;
+ (instancetype)circleImageNamed:(NSString *)name;

+ (instancetype)circleImageNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (instancetype)circleImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


@end



#pragma mark &************  add Image  添加水印

@interface UIImage(PSAddImage)

/**
 图片添加图片水印

 @param image 水印图片
 @param rect rect
 @return value
 */
- (UIImage *) ps_insertImage:(UIImage *) image insertFrame:(CGRect) rect;


/**
 保存到相册
 */
- (void) ps_saveToPhotoLibrary;


/**
 重新调整图片大小
 
 @param name 图片名字
 @return UIImage
 */
+ (UIImage *) ps_resizeImage:(NSString *) name;
/**
 重新调整图片大小
 
 @param name 图片名字
 @return UIImage
 */
+ (UIImage *) ps_resizeImage:(NSString *) name left:(CGFloat)left top:(CGFloat)top;

/**
 截屏
 
 @param renderView renderView
 @return r
 */
+(instancetype)ps_renderView:(UIView *)renderView;
/**
 图片加水印
 
 @param bg 图片
 @param water 水印
 @return 图片
 */
+(instancetype)ps_waterWithBgName:(NSString *)bg waterLogo:(NSString *)water;
/**
 裁剪图片为圆
 
 @param name name图片name
 @param bordersW 边缘宽度
 @param borderColor 边缘颜色
 @return 图片
 */
//+(instancetype)clipWithImageName:(NSString*)name bordersW:(CGFloat)bordersW borderColor:(UIColor *)borderColor;

@end


NS_ASSUME_NONNULL_END
