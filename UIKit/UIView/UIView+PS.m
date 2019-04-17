
//
//  UIView+PS_Radius.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UIView+PS.h"
#import "PS_Head1.h"

#pragma mark ================= radius

@implementation UIView (PS_Radius)

- (void)ps_viewDefaultRadius {
    self.layer.cornerRadius = 10.f;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
- (void)ps_viewRadius:(CGFloat)radius {
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = NO;
}
- (void)ps_viewRound {
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // 贝塞尔曲线(创建一个圆)
    CGFloat w = 180 * PS_Width /375;
    
    CGFloat originX = w/2 ;
    //    CGFloat originY = self.bounds.size.height/2;
    //    NSLog(@"%f--%f",originX,[UIScreen mainScreen].bounds.size.width);
    self.layer.cornerRadius = originX;
    self.layer.masksToBounds = NO;
}

- (void)ps_setRadiusAndShadow:(CGFloat)cornerRadius
                       offset:(CGSize) offsetSize
                 shadowRadius:(CGFloat) shadowRadius
                  shadowColor:(UIColor *) shadowColor
                shadowOpacity:(CGFloat) shadowOpacity {

    self.layer.cornerRadius =cornerRadius;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = offsetSize;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
}

- (instancetype)ps_circular {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGContextAddEllipseInRect(ref, rect);
    CGContextClip(ref);
    CGContextRelease(ref);
    [self drawRect:rect];
    return self;
}

- (void) ps_setRadiusCorner:(UIRectCorner) corner size:(CGSize) size {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = bezierPath.CGPath;
    
    self.layer.mask = layer;
}

- (UIImage *)ps_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)ps_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self ps_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)ps_snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)ps_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIViewController *)ps_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)ps_visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGPoint)ps_convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)ps_convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)ps_convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)ps_convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

@end


#pragma mark -============ Frame
@implementation UIView (Frame)


- (void)setPs_x:(CGFloat)ps_x
{
    CGRect frame = self.frame;
    frame.origin.x = ps_x;
    self.frame = frame;
}

- (CGFloat)ps_x
{
    return self.frame.origin.x;
}

- (void)setPs_y:(CGFloat)ps_y
{
    CGRect frame = self.frame;
    frame.origin.y = ps_y;
    self.frame = frame;
}

- (CGFloat)ps_y
{
    return self.frame.origin.y;
}

- (void)setPs_width:(CGFloat)ps_width
{
    CGRect frame = self.frame;
    frame.size.width = ps_width;
    self.frame = frame;
}

- (CGFloat)ps_width
{
    return self.frame.size.width;
}

- (void)setPs_height:(CGFloat)ps_height
{
    CGRect frame = self.frame;
    frame.size.height = ps_height;
    self.frame = frame;
}

- (CGFloat)ps_height
{
    return self.frame.size.height;
}

- (void)setPs_origin:(CGPoint)ps_origin
{
    CGRect frame = self.frame;
    frame.origin = ps_origin;
    self.frame = frame;
}

- (CGPoint)ps_origin
{
    return self.frame.origin;
}

-(void)setPs_size:(CGSize)ps_size
{
    CGRect frame = self.frame;
    frame.size = ps_size;
    self.frame = frame;
}

-(CGSize)ps_size
{
    return self.frame.size;
}

- (void)setPs_center_x:(CGFloat)ps_center_x
{
    CGPoint point = self.center;
    point.x = ps_center_x;
    self.center = point;
}
- (CGFloat)ps_center_x{
    return self.center.x;
}
- (void)setPs_center_y:(CGFloat)ps_center_y
{
    CGPoint point = self.center;
    point.y = ps_center_y;
    self.center = point;
}
- (CGFloat)ps_center_y{
    return self.center.y;
}

- (CGFloat)ps_right {
    return self.frame.size.width + self.frame.origin.x;
}

- (CGFloat)ps_bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)ps_left {
    return self.frame.origin.x;
}

- (CGFloat)ps_top {
    return self.frame.origin.y;
}

@end
