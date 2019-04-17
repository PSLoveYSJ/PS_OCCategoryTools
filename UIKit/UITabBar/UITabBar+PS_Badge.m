//
//  UITabBar+PS_Badge.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UITabBar+PS_Badge.h"

#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (PS_Badge)

#pragma mark ========== 显示
- (void)ps_showBadgeOnItemIndex:(int)index {
    [self ps_removeBadgeOnItemIndex:index];
    
    //    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 222 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
    
}
- (void)ps_showBadgeNumOnItemIndex:(int)index badgeValues:(NSInteger)values {
    
    [self ps_removeBadgeNumOnItemIndex:index];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    //    [label adjustsFont];
    label.textColor = [UIColor whiteColor];
    label.tag = 888+index;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 9;//圆形
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor redColor];//颜色：红色
    
    CGRect tabFrame2 = self.frame;
    //确定小红点的位置
    float percentX = (index + 0.55) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame2.size.width);
    CGFloat y = ceilf(0.05 * tabFrame2.size.height);
    
    label.frame = CGRectMake(x, y, 18, 18);//圆形大小为10
    [self addSubview:label];
    if (values>99) {
        label.text = @"99+";
        CGSize _size = [self ps_boundingRectWithSize:label.text Font:[UIFont systemFontOfSize:13] Size:(CGSize){65,20}];
        label.frame = CGRectMake(x, y, _size.width, 18);//圆形大小为10
    }else{
        label.text = [NSString stringWithFormat:@"%ld",(long)values];
    }
}
#pragma mark ============== 隐藏
- (void)ps_hideBadgeOnItemIndex:(int)index {
    [self ps_removeBadgeOnItemIndex:index];
}
- (void)ps_hideNumOnItemIndex:(int)index {
    [self ps_removeBadgeNumOnItemIndex:index];
}

#pragma mark - 计算字体
- (CGSize) ps_boundingRectWithSize:(NSString*) txt Font:(UIFont*) font Size:(CGSize) size{
    
    CGSize _size;
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
    _size = [txt boundingRectWithSize:size options: options attributes:attribute context:nil].size;
    
    return _size;
    
}

//移除数字小红点
- (void)ps_removeBadgeNumOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UILabel *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
//移除小红点
- (void)ps_removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 222+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
