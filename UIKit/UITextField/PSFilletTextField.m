//
//  PSFilletTextField.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSFilletTextField.h"
#import "PS_Head1.h"

@implementation PSFilletTextField

- (void)drawRect:(CGRect)rect {
    [self ps_viewRadius:5];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    [self setValue:[NSNumber numberWithInt:5] forKey:@"placeholderRectForBounds"];
    //    [self setValue:[NSNumber numberWithInt:5] forKey:@"_placeholder.padding"];
    //    [self setValue:[NSNumber numberWithInt:10] forKey:@"placeholder.paddingLeft"];
    
}
// 返回placeholderLable bounds 调整placeholder 的位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if (IOS11) {
        return CGRectMake(self.leftView.frame.size.width+5, 0 , self.bounds.size.width, self.bounds.size.height);
    } else {
        return CGRectMake(self.leftView.frame.size.width, 0 , self.bounds.size.width, self.bounds.size.height);
    }
}

// 这个函数是调整placeholder在placeholderLabel中绘制的位置以及范围
- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:CGRectMake(0, 0 , self.bounds.size.width, self.bounds.size.height)];
}

@end
