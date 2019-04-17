//
//  UITextField+PS_Font.h
//  PSOCStudy
//
//  Created by Peng on 2018/4/4.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置字体大小
 */
@interface UITextField (PS_Font)

/**
 Set all text selected.
 */
- (void)ps_selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)ps_setSelectedRange:(NSRange)range;

@end
/**
 * 根据设备 设置字体大小
 */
@interface UIButton (PS_Font)

@end
/**
 *  根据设备 设置字体大小
 */
@interface UILabel (PS_Font)

@end
