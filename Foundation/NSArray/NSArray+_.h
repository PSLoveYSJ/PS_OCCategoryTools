//
//  NSArray+_.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/14.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (_)

/**
 从指定的属性列表数据创建并返回数组。
 
 @param plist   A property list data whose root object is an array.
 @return A new array created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSArray *)ps_arrayWithPlistData:(NSData *)plist;

/**
 从指定的属性列表xml字符串创建并返回数组。
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (nullable NSArray *)ps_arrayWithPlistString:(NSString *)plist;

/**
 将数组序列化为二进制属性列表数据。
 
 @return A binary plist data, or nil if an error occurs.
 */
- (nullable NSData *)ps_plistData;

/**
 将数组序列化为二进制属性列表数据。
 
 @return A plist xml string, or nil if an error occurs.
 */
- (nullable NSString *)ps_plistString;

/**
 返回位于随机索引中的对象
 
 @return The object in the array with a random index value.
 If the array is empty, returns nil.
 */
- (nullable ObjectType)ps_randomObject;

/**
 返回位于索引处的对象，或在越界时返回nil。
 它类似于objectAtIndex:，但它从不抛出异常。
 
 @param index The object located at index.
 */
- (nullable ObjectType)ps_objectOrNilAtIndex:(NSUInteger)index;

/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (nullable NSString *)ps_jsonStringEncoded;

/**
 Convert object to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)ps_jsonPrettyStringEncoded;


@end


#pragma mark &************ log

@interface NSArray<__covariant ObjectType> (PSLog)

@end

#pragma mark &************ NSMutableArray

@interface NSMutableArray<ObjectType>(_)

/**
 从指定的属性列表数据创建并返回数组。
 
 @param plist   A property list data whose root object is an array.
 @return A new array created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSMutableArray *)ps_arrayWithPlistData:(NSData *)plist;

/**
 从指定的属性列表xml字符串创建并返回数组。
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (nullable NSMutableArray *)ps_arrayWithPlistString:(NSString *)plist;

/**
 删除数组中索引值最低的对象。
 If the array is empty, this method has no effect.
 
 @discussion Apple has implemented this method, but did not make it public.
 Override for safe.
 */
- (void)ps_removeFirstObject;

/**
 移除数组中索引值最高的对象。
 If the array is empty, this method has no effect.
 
 @discussion Apple's implementation said it raises an NSRangeException if the
 array is empty, but in fact nothing will happen. Override for safe.
 */
- (void)ps_removeLastObject;

/**
 删除并返回数组中值最低的索引。
 If the array is empty, it just returns nil.
 
 @return The first object, or nil.
 */
- (nullable ObjectType)ps_popFirstObject;

/**
 移除并返回数组中索引值最高的对象。
 If the array is empty, it just returns nil.
 
 @return The first object, or nil.
 */
- (nullable ObjectType)ps_popLastObject;

/**
 在数组的末尾插入给定的对象。
 
 @param anObject The object to add to the end of the array's content.
 This value must not be nil. Raises an NSInvalidArgumentException if anObject is nil.
 */
- (void)ps_appendObject:(id)anObject;

/**
 将给定对象插入数组的开头。
 
 @param anObject The object to add to the end of the array's content.
 This value must not be nil. Raises an NSInvalidArgumentException if anObject is nil.
 */
- (void)ps_prependObject:(id)anObject;

/**
 将另一个给定数组中包含的对象添加到接收端
 数组的内容。
 
 @param objects An array of objects to add to the end of the receiving array's
 content. If the objects is empty or nil, this method has no effect.
 */
- (void)ps_appendObjects:(NSArray *)objects;

/**
 将另一个给定数组中包含的对象添加到接收的开头
 数组的内容。
 
 @param objects An array of objects to add to the beginning of the receiving array's
 content. If the objects is empty or nil, this method has no effect.
 */
- (void)ps_prependObjects:(NSArray *)objects;

/**
 在接收的索引处添加另一个给定数组中包含的对象
 数组的内容。
 
 @param objects An array of objects to add to the receiving array's
 content. If the objects is empty or nil, this method has no effect.
 
 @param index The index in the array at which to insert objects. This value must
 not be greater than the count of elements in the array. Raises an
 NSRangeException if index is greater than the number of elements in the array.
 */
- (void)ps_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/**
 反转该数组中对象的索引。
 Example: Before @[ @1, @2, @3 ], After @[ @3, @2, @1 ].
 */
- (void)ps_reverse;

/**
对数组中的对象进行随机排序。
 */
- (void)ps_shuffle;


@end


NS_ASSUME_NONNULL_END
