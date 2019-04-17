//
//  UIButton+PS_TitleImg.m
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "UIButton+PS_TitleImg.h"

@implementation UIButton (PS_TitleImg)

- (void)ps_centerImageAndTitle:(float)space {
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    //    self.imageView.backgroundColor = [UIColor redColor];
    //    self.titleLabel.backgroundColor = [UIColor grayColor];
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

- (void)ps_centerImageAndTitle {
    const int Default_Spacing = 6.0f;
    [self ps_centerImageAndTitle:Default_Spacing];
}

@end
