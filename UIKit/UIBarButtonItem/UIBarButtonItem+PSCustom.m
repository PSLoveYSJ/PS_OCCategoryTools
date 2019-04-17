//
//  UIBarButtonItem+PSCustom.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/22.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UIBarButtonItem+PSCustom.h"
#import "PS_Head1.h"

@implementation UIBarButtonItem (PSCustom)

+(UIBarButtonItem *)ps_itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *btn=[[UIButton alloc]init];
    // 这里需要注意：由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    // 让按钮图片左移15
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [btn setImage:[UIImage ps_resizeImage:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage ps_resizeImage:highIcon] forState:UIControlStateHighlighted];
    btn.frame=CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
