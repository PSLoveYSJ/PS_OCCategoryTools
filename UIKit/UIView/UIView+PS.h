//
//  UIView+PS_Radius.h
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark ===================radius

@interface UIView (PS_Radius)

// 还有一种方法
/**
 设置圆角 和 阴影

 @param cornerRadius 圆角
 @param offsetSize 阴影偏移量
 @param shadowRadius 阴影圆角
 @param shadowColor 阴影颜色
 @param shadowOpacity 阴影透明度
 */
- (void)ps_setRadiusAndShadow:(CGFloat)cornerRadius
                       offset:(CGSize) offsetSize
                 shadowRadius:(CGFloat) shadowRadius
                  shadowColor:(UIColor *) shadowColor
                shadowOpacity:(CGFloat) shadowOpacity;

/**
 * 设置默认10 圆角
 */
- (void) ps_viewDefaultRadius ;

/**
 * 设置圆角
 * @param radius 圆角大小
 */
- (void) ps_viewRadius:( CGFloat ) radius;

/**
 * 圆形的 嘎嘎
 */
- (void) ps_viewRound;

/**
 设置圆角

 @return 当前
 */
- (instancetype) ps_circular;

/**
 设置指定方向的圆角

 @param corner 圆角方向
 @param size 大小
 */
- (void) ps_setRadiusCorner:(UIRectCorner) corner size:(CGSize) size;


/**
 将UIView剪切成图片

 @return 图片
 */
- (UIImage *)ps_snapshotImage;

/**
 创建完整视图层次结构的快照映像。
 它比snapshotImage快，但可能会导致屏幕更新。
 查看-[UIView drawViewHierarchyInRect:afterScreenUpdates:]获取更多信息。
 */
- (UIImage *)ps_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)ps_snapshotPDF;

- (void) ps_removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *ps_viewController;

/**
 在考虑父视图和窗口的情况下，返回屏幕上的可见alpha。
 */
@property (nonatomic, readonly) CGFloat ps_visibleAlpha;

/**
 将接收方坐标系统中的点转换为指定视图或窗口的点。

 @param point 在接收方的局部坐标系(边界)中指定的点
 @param view 视图要转换到其坐标系统点的视图或窗口 如果视图为nil，则此方法将转换为窗口基坐标
 @return 返回转换到视图坐标系统的点
 */
- (CGPoint)ps_convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 将给定视图或窗口的坐标系统中的点转换为接收方的坐标系统中的点
 
 @param point 在视图的局部坐标系(边界)中指定的点
 @param view  视图或窗口的坐标系统中的点.
 如果视图为nil，则此方法将从窗口基坐标转换.
 @return 转换到接收方的局部坐标系(边界)的点
 */
- (CGPoint)ps_convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;
/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)ps_convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)ps_convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@end

#pragma mark =============== frame
@interface UIView (Frame)

@property (nonatomic, assign) CGFloat ps_x;
@property (nonatomic, assign) CGFloat ps_y;
@property (nonatomic, assign) CGFloat ps_width;
@property (nonatomic, assign) CGFloat ps_height;
@property (nonatomic, assign) CGFloat ps_center_x;
@property (nonatomic, assign) CGFloat ps_center_y;

@property (nonatomic, assign, readonly) CGFloat ps_top;
@property (nonatomic, assign, readonly) CGFloat ps_left;
@property (nonatomic, assign, readonly) CGFloat ps_right;
@property (nonatomic, assign, readonly) CGFloat ps_bottom;


@property (nonatomic, assign) CGPoint ps_origin;
@property (nonatomic, assign) CGSize  ps_size;

@end
