//
//  NSString+_.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/14.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PSCharacterSet) {
    PSCharacterSetWhitespaceCharacterSet,// 空格
    PSCharacterSetWhitespaceAndNewlineCharacterSet, // 空格 和new line
};


@interface NSString (_)

#pragma mark &************ hash

#pragma mark &************ NSNumber Compatible
///=============================================================================
/// @name NSNumber Compatible
///=============================================================================

// Now you can use NSString as a NSNumber.
@property (readonly) char ps_charValue;
@property (readonly) unsigned char ps_unsignedCharValue;
@property (readonly) short ps_shortValue;
@property (readonly) unsigned short ps_unsignedShortValue;
@property (readonly) unsigned int ps_unsignedIntValue;
@property (readonly) long ps_longValue;
@property (readonly) unsigned long ps_unsignedLongValue;
@property (readonly) unsigned long long ps_unsignedLongLongValue;
@property (readonly) NSUInteger ps_unsignedIntegerValue;


#pragma mark &************ init

/**
 获取手机的UUID

 @return UUID
 */
+ (NSString *) ps_stringStringWithUUID;

/**
 返回一个字符串，该字符串包含给定UTF32Char中的字符。
 
 @param char32 A UTF-32 character.
 @return A new string, or nil if the character is invalid.
 */
+ (nullable NSString *)ps_stringWithUTF32Char:(UTF32Char)char32;

/**
 Returns a string containing the characters in a given UTF32Char array.
 
 @param char32 An array of UTF-32 character.
 @param length The character count in array.
 @return A new string, or nil if an error occurs.
 */
+ (nullable NSString *)ps_stringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length;



#pragma mark &************  operation

/**
 Enumerates the unicode characters (UTF-32) in the specified range of the string.
 
 @param range The range within the string to enumerate substrings.
 @param block The block executed for the enumeration. The block takes four arguments:
 char32: The unicode character.
 range: The range in receiver. If the range.length is 1, the character is in BMP;
 otherwise (range.length is 2) the character is in none-BMP Plane and stored
 by a surrogate pair in the receiver.
 stop: A reference to a Boolean value that the block can use to stop the enumeration
 by setting *stop = YES; it should not touch *stop otherwise.
 */
- (void)ps_enumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block;

/**
 Add scale modifier to the file name (without path extension),
 From @"name" to @"name@2x".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)ps_stringByAppendingNameScale:(CGFloat)scale;

/**
 Add scale modifier to the file path (with path extension),
 From @"name.png" to @"name@2x.png".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon.png" </td><td>"icon@2x.png" </td></tr>
 <tr><td>"icon..png"</td><td>"icon.@2x.png"</td></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon."    </td><td>"icon.@2x"    </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)ps_stringByAppendingPathScale:(CGFloat)scale;
/**
 Return the path scale.
 
 e.g.
 <table>
 <tr><th>Path            </th><th>Scale </th></tr>
 <tr><td>"icon.png"      </td><td>1     </td></tr>
 <tr><td>"icon@2x.png"   </td><td>2     </td></tr>
 <tr><td>"icon@2.5x.png" </td><td>2.5   </td></tr>
 <tr><td>"icon@2x"       </td><td>1     </td></tr>
 <tr><td>"icon@2x..png"  </td><td>1     </td></tr>
 <tr><td>"icon@2x.png/"  </td><td>1     </td></tr>
 </table>
 */
- (CGFloat)ps_pathScale;

- (NSString *) ps_stringByTrimmingInSet:(PSCharacterSet) characterSet;

/**
 首字母小写

 @return string
 */
- (NSString *) ps_lowercaseFirstString;

/**
 首字母大写

 @return string
 */
- (NSString *)ps_uppercaseFirstString;

/**
nil, @"", @"  ", @"\n" will Returns YES; otherwise Returns NO.
*/
- (BOOL) ps_isEmpty;

/**
 Returns YES if the target string is contained within the receiver.
 @param string A string to test the the receiver.
 
 @discussion Apple has implemented this method in iOS8.
 */
- (BOOL)ps_containsString:(NSString *)string;

/**
 Returns YES if the target CharacterSet is contained within the receiver.
 @param set  A character set to test the the receiver.
 */
- (BOOL)ps_containsCharacterSet:(NSCharacterSet *)set;

/**
 Try to parse this string and returns an `NSNumber`.
 @return Returns an `NSNumber` if parse succeed, or nil if an error occurs.
 */
- (nullable NSNumber *)ps_numberValue;

/**
 Returns an NSData using UTF-8 encoding.
 */
- (nullable NSData *)ps_dataValue;

/**
 Returns NSMakeRange(0, self.length).
 */
- (NSRange)ps_rangeOfAll;

/**
 Returns an NSDictionary/NSArray which is decoded from receiver.
 Returns nil if an error occurs.
 
 e.g. NSString: @"{"name":"a","count":2}"  => NSDictionary: @[@"name":@"a",@"count":@2]
 */
- (nullable id)ps_jsonValueDecoded;

/**
 Create a string from the file in main bundle (similar to [UIImage imageNamed:]).
 
 @param name The file name (in main bundle).
 
 @return A new string create from the file in UTF-8 character encoding.
 */
+ (nullable NSString *)ps_stringNamed:(NSString *)name;

#pragma mark &************ 转码 解码 hash

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)ps_stringByURLEncode;

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *)ps_stringByURLDecode;

/**
 转换HTML代码

 @return s
 */
- (NSString *) ps_conversionHTML;

/**
 XML 解码

 @return string
 */
- (NSString *) ps_stringByDecodingXMLEntities;

/**
 MD5 32位小写

 @return MD5
 */
- (NSString *) ps_MD5_ForLower32Byte;

/**
 MD5 32位大写
 
 @return MD5
 */
- (NSString *) ps_MD5_ForUpper32Byte;

/**
 MD5 16位小写
 
 @return MD5
 */
- (NSString *) ps_MD5_ForLower16Byte;

/**
 MD5 16位小写
 
 @return MD5
 */
- (NSString *) ps_MD5_ForUpper16Byte;


#pragma mark &************ 字体

/**
 自适应字体

 @param font 字体
 @param containerSize 容器大小
 @return CGFloat
 */
- (CGFloat) ps_fontsizeWithFont:(UIFont *) font containerSize:(CGSize) containerSize;


/**
 获取文字展示需要的宽度

 @param font 字体
 @return 宽度
 */
- (CGFloat) ps_widthForFont:(UIFont *) font;

/**
 获取字体展示需要的高度

 @param font 字体
 @param width 宽度
 @return 高度
 */
- (CGFloat) ps_heightForFont:(UIFont *) font width:(CGFloat) width;

/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize) ps_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


#pragma mark &************ regular  Expression

/**
 它是否能匹配正则表达式
 
 @param regex  The regular expression
 @param options     The matching options to report.
 @return YES if can match the regex; otherwise, NO.
 */
- (BOOL)ps_matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;

/**
 匹配正则表达式，并使用匹配中的每个对象执行给定块。
 
 @param regex    The regular expression
 @param options  The matching options to report.
 @param block    The block to apply to elements in the array of matches.
 The block takes four arguments:
 match: The match substring.
 matchRange: The matching options.
 stop: A reference to a Boolean value. The block can set the value
 to YES to stop further processing of the array. The stop
 argument is an out-only argument. You should only ever set
 this Boolean to YES within the Block.
 */
- (void)ps_enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;

/**
 Returns a new string containing matching regular expressions replaced with the template string.
 
 @param regex       The regular expression
 @param options     The matching options to report.
 @param replacement The substitution template used when replacing matching instances.
 
 @return A string with matching regular expressions replaced by the template string.
 */
- (NSString *)ps_stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement;

@end


NS_ASSUME_NONNULL_END
