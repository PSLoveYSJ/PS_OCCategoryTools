//
//  UITextView+PSPlaceholder.m
//  hehe
//
//  Created by Peng on 2018/4/19.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UITextView+PSPlaceholder.h"
#import <objc/runtime.h>

static char ps_placeholderKey;
static char ps_placeholderLbKey;

@interface UITextView()

@property (nonatomic, readonly) UILabel *placeholderLabel;


@end

@implementation UITextView (PSPlaceholder)

+ (void)load {
    [super load];
    // 交换 layout Subviews
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")), class_getInstanceMethod(self.class, @selector(ps_layoutSubviews)));
    // 交换 dealloc 方法
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(ps_dealloc)));
    // 交换 setText 方法
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(ps_setText:)));
}
// 设置placeholderLabel frame
- (void) ps_layoutSubviews {
    if (self.ps_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.placeholderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self ps_layoutSubviews];
}
// 移除通知
- (void) ps_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self ps_dealloc];
}
// text 改变了
- (void) ps_setText:(NSString *) text {
    [self ps_setText:text];
    if (self.ps_placeHolder) {
        [self ps_updatePlaceHolder];
    }
}

#pragma mark ===========  get and  setter
- (UILabel *)placeholderLabel {
    UILabel *placeholderLb = objc_getAssociatedObject(self, &ps_placeholderLbKey);
    if (!placeholderLb) {
        placeholderLb = [[UILabel alloc] init];
        placeholderLb.numberOfLines = 0;
        placeholderLb.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, &ps_placeholderLbKey, placeholderLb, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ps_updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeholderLb;
}

- (NSString *)ps_placeHolder {
   return objc_getAssociatedObject(self, &ps_placeholderKey);
}
- (void)setPs_placeHolder:(NSString *)ps_placeHolder {
    objc_setAssociatedObject(self, &ps_placeholderKey, ps_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ps_updatePlaceHolder];
}
- (UIColor *)ps_placeHolderColor {
    return self.placeholderLabel.textColor;
}
- (void)setPs_placeHolderColor:(UIColor *)ps_placeHolderColor {
    self.placeholderLabel.textColor = ps_placeHolderColor;
}

#pragma mark - update
- (void)ps_updatePlaceHolder{
    if (self.text.length) {
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    self.placeholderLabel.font = self.font?self.font:self.ps_getDefaultFont;
    self.placeholderLabel.textAlignment = self.textAlignment;
    self.placeholderLabel.text = self.ps_placeHolder;
    [self insertSubview:self.placeholderLabel atIndex:0];
}
// 获取默认字体
- (UIFont *) ps_getDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
