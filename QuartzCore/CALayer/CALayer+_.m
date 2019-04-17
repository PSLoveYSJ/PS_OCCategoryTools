//
//  CALayer+_.m
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import "CALayer+_.h"


UIViewContentMode PSCAGravityToUIViewContentMode(NSString *gravity) {
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{ kCAGravityCenter:@(UIViewContentModeCenter),
                 kCAGravityTop:@(UIViewContentModeTop),
                 kCAGravityBottom:@(UIViewContentModeBottom),
                 kCAGravityLeft:@(UIViewContentModeLeft),
                 kCAGravityRight:@(UIViewContentModeRight),
                 kCAGravityTopLeft:@(UIViewContentModeTopLeft),
                 kCAGravityTopRight:@(UIViewContentModeTopRight),
                 kCAGravityBottomLeft:@(UIViewContentModeBottomLeft),
                 kCAGravityBottomRight:@(UIViewContentModeBottomRight),
                 kCAGravityResize:@(UIViewContentModeScaleToFill),
                 kCAGravityResizeAspect:@(UIViewContentModeScaleAspectFit),
                 kCAGravityResizeAspectFill:@(UIViewContentModeScaleAspectFill) };
    });
    if (!gravity) return UIViewContentModeScaleToFill;
    return (UIViewContentMode)((NSNumber *)dic[gravity]).integerValue;
}

NSString *PSUIViewContentModeToCAGravity(UIViewContentMode contentMode) {
    switch (contentMode) {
        case UIViewContentModeScaleToFill: return kCAGravityResize;
        case UIViewContentModeScaleAspectFit: return kCAGravityResizeAspect;
        case UIViewContentModeScaleAspectFill: return kCAGravityResizeAspectFill;
        case UIViewContentModeRedraw: return kCAGravityResize;
        case UIViewContentModeCenter: return kCAGravityCenter;
        case UIViewContentModeTop: return kCAGravityTop;
        case UIViewContentModeBottom: return kCAGravityBottom;
        case UIViewContentModeLeft: return kCAGravityLeft;
        case UIViewContentModeRight: return kCAGravityRight;
        case UIViewContentModeTopLeft: return kCAGravityTopLeft;
        case UIViewContentModeTopRight: return kCAGravityTopRight;
        case UIViewContentModeBottomLeft: return kCAGravityBottomLeft;
        case UIViewContentModeBottomRight: return kCAGravityBottomRight;
        default: return kCAGravityResize;
    }
}

@implementation CALayer (_)

- (UIImage *)ps_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
    [self renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)ps_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.shadowOpacity = 1;
    self.shouldRasterize = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)ps_removeAllSublayers {
    while (self.sublayers.count) {
        [self.sublayers.lastObject removeFromSuperlayer];
    }
}

- (UIViewContentMode)ps_contentMode {
    return PSCAGravityToUIViewContentMode(self.contentsGravity);
}

- (void)setPs_contentMode:(UIViewContentMode)contentMode {
    self.contentsGravity = PSUIViewContentModeToCAGravity(contentMode);
}

@end

@implementation CALayer(Frame)

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

- (CGFloat)ps_right {
    return self.frame.size.width + self.frame.origin.x;
}

- (CGFloat)ps_bottom {
    return self.frame.size.height + self.frame.origin.y;
}


@end
