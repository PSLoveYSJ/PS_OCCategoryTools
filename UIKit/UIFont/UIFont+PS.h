//
//  UIFont+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/2.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreGraphics;
@import CoreText;

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (PS)<NSCoding>

#pragma mark - Font Traits
///=============================================================================
/// @name Font Traits
///=============================================================================

/**
 粗体
 */
@property (nonatomic, readonly) BOOL ps_isBold NS_AVAILABLE_IOS(7_0);
/**
 斜体
 */
@property (nonatomic, readonly) BOOL ps_isItalic NS_AVAILABLE_IOS(7_0);
/**
 字体是否是单声道空间
 */
@property (nonatomic, readonly) BOOL ps_isMonoSpace NS_AVAILABLE_IOS(7_0);
/**
 是否是颜色符号(such as Emoji)
 */
@property (nonatomic, readonly) BOOL ps_isColorGlyphs NS_AVAILABLE_IOS(7_0);
/**
 字体粗细
 */
@property (nonatomic, readonly) CGFloat ps_fontWeight NS_AVAILABLE_IOS(7_0);

/**
 Create a bold font from receiver.
 @return A bold font, or nil if failed.
 */
- (nullable UIFont *)ps_fontWithBold NS_AVAILABLE_IOS(7_0);
/**
 Create a italic font from receiver.
 @return A italic font, or nil if failed.
 */
- (nullable UIFont *)ps_fontWithItalic NS_AVAILABLE_IOS(7_0);

/**
 Create a bold and italic font from receiver.
 @return A bold and italic font, or nil if failed.
 */
- (nullable UIFont *)ps_fontWithBoldItalic NS_AVAILABLE_IOS(7_0);

/**
 Create a normal (no bold/italic/...) font from receiver.
 @return A normal font, or nil if failed.
 */
- (nullable UIFont *)ps_fontWithNormal NS_AVAILABLE_IOS(7_0);

#pragma mark **************** Create font


/**
 Creates and returns a font object for the specified CTFontRef.
 
 @param CTFont  CoreText font.
 */
+ (nullable UIFont *)ps_fontWithCTFont:(CTFontRef)CTFont;

/**
 Creates and returns a font object for the specified CGFontRef and size.
 
 @param CGFont  CoreGraphic font.
 @param size    Font size.
 */
+ (nullable UIFont *)ps_fontWithCGFont:(CGFontRef)CGFont size:(CGFloat)size;

/**
 Creates and returns the CTFontRef object. (need call CFRelease() after used)
 */
- (nullable CTFontRef)ps_CTFontRef CF_RETURNS_RETAINED;

/**
 Creates and returns the CGFontRef object. (need call CFRelease() after used)
 */
- (nullable CGFontRef)ps_CGFontRef CF_RETURNS_RETAINED;


#pragma mark - Load and unload font
///=============================================================================
/// @name Load and unload font
///=============================================================================

/**
 Load the font from file path. Support format:TTF,OTF.
 If return YES, font can be load use it PostScript Name: [UIFont fontWithName:...]
 
 @param path    font file's full path
 */
+ (BOOL)ps_loadFontFromPath:(NSString *)path;

/**
 Unload font from file path.
 
 @param path    font file's full path
 */
+ (void)ps_unloadFontFromPath:(NSString *)path;

/**
 Load the font from data. Support format:TTF,OTF.
 
 @param data  Font data.
 
 @return UIFont object if load succeed, otherwise nil.
 */
+ (nullable UIFont *)ps_loadFontFromData:(NSData *)data;

/**
 Unload font which is loaded by loadFontFromData: function.
 
 @param font the font loaded by loadFontFromData: function
 
 @return YES if succeed, otherwise NO.
 */
+ (BOOL)ps_unloadFontFromData:(UIFont *)font;


#pragma mark - Dump font data

/**
 Serialize and return the font data.
 
 @param font The font.
 
 @return data in TTF, or nil if an error occurs.
 */
+ (nullable NSData *)ps_dataFromFont:(UIFont *)font;

/**
 Serialize and return the font data.
 
 @param cgFont The font.
 
 @return data in TTF, or nil if an error occurs.
 */
+ (nullable NSData *)ps_dataFromCGFont:(CGFontRef)cgFont;

@end

NS_ASSUME_NONNULL_END
