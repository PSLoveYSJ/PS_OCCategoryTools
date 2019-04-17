//
//  UITextField+PS_Font.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UITextField+PS_Font.h"
#import <objc/runtime.h>
#import "PS_Head1.h"

//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale PS_Width / 375

#pragma mark ------//  UITextField PSFont

@implementation UITextField (PS_Font)

- (void)ps_selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)ps_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(ps_initWithCode:));
    method_exchangeImplementations(imp, myImp);
}
- (id) ps_initWithCode:(NSCoder *) aDecode {
    [self ps_initWithCode:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
            //            self.titleLabel.font = [UIFont systemFontOfSize:fontSize*SizeScale];
            self.font = [UIFont systemFontOfSize:(fontSize *SizeScale)];
        }
    }
    return self;
}

@end

#pragma mark ------//  UIButton PSFont

@implementation UIButton (PS_Font)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(ps_initWithCode:));
    method_exchangeImplementations(imp, myImp);
}
- (id) ps_initWithCode:(NSCoder *) aDecode {
    [self ps_initWithCode:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.titleLabel.tag != 333){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:(fontSize *SizeScale)];
        }
    }
    return self;
}
@end

#pragma mark ------//  UILabel PSFont

@implementation UILabel (PS_Font)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(ps_initWithCode:));
    method_exchangeImplementations(imp, myImp);
}
- (id) ps_initWithCode:(NSCoder *) aDecode {
    [self ps_initWithCode:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:(fontSize *SizeScale)];
        }
    }
    return self;
}

@end
