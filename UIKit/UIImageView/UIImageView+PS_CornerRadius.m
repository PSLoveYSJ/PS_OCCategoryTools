//
//  UIImageView+PS_CornerRadius.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/3.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UIImageView+PS_CornerRadius.h"

#import <objc/runtime.h>


const char kPSCornerRadius;
const char kPSCornerRoundingCorners;
const char kPSCornerIsRounding;
const char kPSCornerHadAddObserver;
const char kPSCornerProcessedImage;
const char kPSCornerBackgroundColor;

const char kPSCornerBorderWidth;
const char kPSCornerBorderColor;

@interface UIImageView()

/**
 * 圆角
 */
@property (assign, nonatomic) CGFloat ps_radius;
/**
 * 圆角类型
 */
@property (assign, nonatomic) UIRectCorner ps_roundingCorners;
/**
 * 边角宽度
 */
@property (assign, nonatomic) CGFloat ps_borderWidth;
/**
 * 边角颜色
 */
@property (strong, nonatomic) UIColor *ps_borderColor;

/**
 * 背景颜色
 */
@property (nonatomic, strong) UIColor *ps_backgroundColor;
/**
 * 是否添加 键值通知
 */
@property (assign, nonatomic) BOOL ps_hadAddObserver;
/**
 * 是否是圆的图片
 */
@property (assign, nonatomic) BOOL ps_isRounding;


@end

@implementation UIImageView (PS_CornerRadius)

#pragma mark ========== init
- (void)ps_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor: (UIColor *) backgroundColor {
    self.ps_radius = cornerRadius;
    self.ps_roundingCorners = rectCornerType;
    self.ps_isRounding = NO;
    self.ps_backgroundColor = backgroundColor;
    if (!self.ps_hadAddObserver) {
        // NSKeyValueObservingOptionNew  新值
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.ps_hadAddObserver = YES;
    }
}
- (instancetype)ps_initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor:(UIColor *)backgroundColor {
    if (self == [super init]) {
        [self ps_cornerRadiusAdvance:cornerRadius rectCornerType:rectCornerType backgroundColor:backgroundColor];
    }
    return self;
}
- (instancetype)ps_initwithRoundImageView {
    if (self == [super init]) {
        [self ps_cornerRadiusRound];
    }
    return self;
}
- (void)ps_cornerRadiusRound {
    self.ps_isRounding = YES;
    if (!self.ps_hadAddObserver) {
        // NSKeyValueObservingOptionNew  新值
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.ps_hadAddObserver = YES;
    }
}

#pragma mark --================// 核心方法
/**
 * @brief clip the cornerRadius with image, draw the backgroundColor you want, UIImageView must be setFrame before, no off-screen-rendered, no Color Blended layers
 */
- (void)ps_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor: (UIColor *) backgroundColor{
    CGSize size = self.bounds.size;
    // 屏幕分辨率
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    // 第一个参数 Size  第二个参数 yes 透明  no 不透明   第三个参数 屏幕分辨率
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    // 如果当前上下文 == nil  返回
    if (nil == UIGraphicsGetCurrentContext()) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    if (backgroundColor != nil) {
        [backgroundColor setFill];
        [backgroundRect fill];
    }
    // 剪切被接收者路径包围的区域该路径是带有剪切路径的当前绘图上下文。使得其成为我们当前的剪切路径
    [cornerPath addClip];
    [image drawInRect:self.bounds];
    // 添加边角
    [self ps_drawBorder:cornerPath];
    UIImage *processImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    objc_setAssociatedObject(processImage, &kPSCornerProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = processImage;
}

#pragma mark ============= private  method
- (void) ps_drawBorder:(UIBezierPath *) path {
    if (self.ps_borderWidth != 0 && self.ps_borderColor != nil) {
        [path setLineWidth:2 * self.ps_borderWidth];
        [self.ps_borderColor setStroke];
        [path stroke];
    }
}
- (void)dealloc {
    if (self.ps_hadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
}

#pragma mark =============== KVO for .image
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *image = change[NSKeyValueChangeNewKey];
        if ([image isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(image, &kPSCornerProcessedImage) intValue] == 1) {
            return;
        }
        // 交换方法
        [self ps_validateFrame];
        // 判断是否是圆形的
        if (self.ps_isRounding) {
            [self ps_cornerRadiusWithImage:image cornerRadius:self.frame.size.width / 2 rectCornerType:UIRectCornerAllCorners backgroundColor:self.ps_backgroundColor];
        } else if (self.ps_radius != 0 && self.ps_roundingCorners != 0 &&  self.image != nil) {
            [self ps_cornerRadiusWithImage:image cornerRadius:self.ps_radius rectCornerType:self.ps_roundingCorners backgroundColor:self.ps_backgroundColor];
        }
    }
}
#pragma mark ===========黑魔法 交换 layoutSubviews
- (void) ps_validateFrame {
    if (self.frame.size.width == 0) {
        [self.class ps_swizzleMethod:@selector(layoutSubviews) anotherSel:@selector(ps_layoutSubviews)];
    }
}
+ (void) ps_swizzleMethod:(SEL) sel  anotherSel:(SEL) otherSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod(self, sel);
        Method otherMethod = class_getInstanceMethod(self, otherSel);
        method_exchangeImplementations(oneMethod, otherMethod);
    });
}

- (void) ps_layoutSubviews {
    [super layoutSubviews];
    if (self.ps_isRounding) {
        [self ps_cornerRadiusWithImage:self.image cornerRadius:self.frame.size.width / 2 rectCornerType:UIRectCornerAllCorners backgroundColor:self.ps_backgroundColor];
    } else if (self.ps_radius != 0 && self.ps_roundingCorners != 0 &&  self.image != nil) {
        [self ps_cornerRadiusWithImage:self.image cornerRadius:self.ps_radius rectCornerType:self.ps_roundingCorners backgroundColor:self.ps_backgroundColor];
    }
}

#pragma mark ================ property
- (UIColor *)ps_backgroundColor {
    return objc_getAssociatedObject(self, &kPSCornerBackgroundColor);
}
- (void)setPs_backgroundColor:(UIColor *)ps_backgroundColor {
    objc_setAssociatedObject(self, &kPSCornerBackgroundColor, ps_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)ps_radius {
    return [objc_getAssociatedObject(self, &kPSCornerRadius) floatValue];
}
- (void)setPs_radius:(CGFloat)ps_radius {
    objc_setAssociatedObject(self, &kPSCornerRadius, @(ps_radius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIRectCorner)ps_roundingCorners {
    return  [objc_getAssociatedObject(self, &kPSCornerRoundingCorners) unsignedIntegerValue];
}
- (void)setPs_roundingCorners:(UIRectCorner)ps_roundingCorners {
    objc_setAssociatedObject(self, &kPSCornerRoundingCorners, @(ps_roundingCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)ps_isRounding {
    return [objc_getAssociatedObject(self, &kPSCornerIsRounding) boolValue];
}
- (void)setPs_isRounding:(BOOL)ps_isRounding {
    objc_setAssociatedObject(self, &kPSCornerIsRounding, @(ps_isRounding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)ps_hadAddObserver {
    return [objc_getAssociatedObject(self, &kPSCornerHadAddObserver) boolValue];
}
- (void)setPs_hadAddObserver:(BOOL)ps_hadAddObserver {
    objc_setAssociatedObject(self, &kPSCornerHadAddObserver, @(ps_hadAddObserver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)ps_borderWidth {
    return [objc_getAssociatedObject(self, &kPSCornerBorderWidth) floatValue];
}
- (void)setPs_borderWidth:(CGFloat)ps_borderWidth {
    objc_setAssociatedObject(self, &kPSCornerBorderWidth, @(ps_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)ps_borderColor {
    return objc_getAssociatedObject(self, &kPSCornerBorderColor);
}
- (void)setPs_borderColor:(UIColor *)ps_borderColor {
    objc_setAssociatedObject(self, &kPSCornerBorderColor, ps_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius image:(UIImage *) image {
    if (self == [super initWithFrame:frame]) {
        // 方法 -1
        
        
        
        //  方法 0 bezier 曲线 + Core Graphics
        //        self.frame = frame;
        //        self.image = image;
        //        //开始对imageView进行画图
        //        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
        //
        //        //使用贝塞尔曲线画出一个圆形图
        //        [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width] addClip];
        //
        //        [self drawRect:self.bounds];
        //
        //        self.image = UIGraphicsGetImageFromCurrentImageContext();
        //
        //        //结束画图
        //        UIGraphicsEndImageContext();
        //
        
        // 方法 1  cornerRadius 会触发离屏渲染
        //设置圆角
        //        imageView.layer.cornerRadius =50
        //
        //        //将多余的部分切掉
        //        imageView.layer.masksToBounds = YES;
        
        // 方法 2 CAShapeLayer和UIBezierPath 会触发离屏渲染
        //        self.frame = frame;
        //        self.image = image;
        //        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
        //
        //        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //
        //        //设置大小
        //        maskLayer.frame = self.bounds;
        //
        //        //设置图形样子
        //        maskLayer.path = maskPath.CGPath;
        //
        //        self.layer.mask = maskLayer;
        
        // 方法 3 Core Graphics框架画出一个圆角 不触发离屏渲染 但是会增加内存 相当于多了一份视图拷贝会增加内存开销 能保持较高帧率
        //        self.frame = frame;
        //        self.image = image;
        //        //开始对imageView进行画图
        //        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        //
        //        // 获得图形上下文
        //        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //
        //        // 设置一个范围
        //        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        //
        //        // 根据一个rect创建一个椭圆
        //        CGContextAddEllipseInRect(ctx, rect);
        //
        //        // 裁剪
        //        CGContextClip(ctx);
        //
        //        // 将原照片画到图形上下文
        //        [self.image drawInRect:rect];
        //
        //        // 从上下文上获取剪裁后的照片
        //        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //
        //        // 关闭上下文
        //        UIGraphicsEndImageContext();
        //
        //        self.image = newImage;
        
        
    }
    return self;
}


@end
