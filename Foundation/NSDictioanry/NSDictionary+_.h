//
//  NSDictionary+_.h
//  PSOCStudy
//
//  Created by Peng on 2018/10/9.
//  Copyright © 2018 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (_)

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSDictionary *)ps_dictionaryWithPlistData:(NSData *)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (nullable NSDictionary *)ps_dictionaryWithPlistString:(NSString *)plist;

/**
 Serialize the dictionary to a binary property list data.
 
 @return A binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
- (nullable NSData *)ps_plistData;

/**
 Serialize the dictionary to a xml property list string.
 
 @return A plist xml string, or nil if an error occurs.
 */
- (nullable NSString *)ps_plistString;

/**
 Returns a new array containing the dictionary's keys sorted.
 The keys should be NSString, and they will be sorted ascending.
 
 @return A new array containing the dictionary's keys,
 or an empty array if the dictionary has no entries.
 */
- (NSArray *)ps_allKeysSorted;

/**
 Returns a new array containing the dictionary's values sorted by keys.
 
 The order of the values in the array is defined by keys.
 The keys should be NSString, and they will be sorted ascending.
 
 @return A new array containing the dictionary's values sorted by keys,
 or an empty array if the dictionary has no entries.
 */
- (NSArray *)ps_allValuesSortedByKeys;

/**
 Returns a BOOL value tells if the dictionary has an object for key.
 
 @param key The key.
 */
- (BOOL)ps_containsObjectForKey:(id)key;

/**
 Returns a new dictionary containing the entries for keys.
 If the keys is empty or nil, it just returns an empty dictionary.
 
 @param keys The keys.
 @return The entries for the keys.
 */
- (NSDictionary *)ps_entriesForKeys:(NSArray *)keys;

/**
 Convert dictionary to json string. return nil if an error occurs.
 */
- (nullable NSString *)ps_jsonStringEncoded;

/**
 Convert dictionary to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)ps_jsonPrettyStringEncoded;

/**
 Try to parse an XML and wrap it into a dictionary.
 If you just want to get some value from a small xml, try this.
 
 example XML: "<config><a href="test.com">link</a></config>"
 example Return: @{@"_name":@"config", @"a":{@"_text":@"link",@"href":@"test.com"}}
 
 @param xmlDataOrString XML in NSData or NSString format.
 @return Return a new dictionary, or nil if an error occurs.
 */
+ (nullable NSDictionary *)ps_dictionaryWithXML:(id)xmlDataOrString;

#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary Value Getter
///=============================================================================

- (BOOL)ps_boolValueForKey:(NSString *)key default:(BOOL)def;

- (char)ps_charValueForKey:(NSString *)key default:(char)def;
- (unsigned char)ps_unsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

- (short)ps_shortValueForKey:(NSString *)key default:(short)def;
- (unsigned short)ps_unsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

- (int)ps_intValueForKey:(NSString *)key default:(int)def;
- (unsigned int)ps_unsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

- (long)ps_longValueForKey:(NSString *)key default:(long)def;
- (unsigned long)ps_unsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

- (long long)ps_longLongValueForKey:(NSString *)key default:(long long)def;
- (unsigned long long)ps_unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

- (float)ps_floatValueForKey:(NSString *)key default:(float)def;
- (double)ps_doubleValueForKey:(NSString *)key default:(double)def;

- (NSInteger)ps_integerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSUInteger)ps_unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

- (nullable NSNumber *)ps_numberValueForKey:(NSString *)key default:(nullable NSNumber *)def;
- (nullable NSString *)ps_stringValueForKey:(NSString *)key default:(nullable NSString *)def;


/**
 清除字典值为NULL的键值

 @param key 键值
 @return 值
 */
- (NSString *) ps_objectForNoNullKey:(NSString *) key;

@end


#pragma mark &************ log

@interface NSDictionary(PSLog)

@end

#pragma mark &************ NSMutableDictionary

@interface NSMutableDictionary(_)

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (nullable NSMutableDictionary *)ps_dictionaryWithPlistData:(NSData *)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 */
+ (nullable NSMutableDictionary *)ps_dictionaryWithPlistString:(NSString *)plist;


/**
 Removes and returns the value associated with a given key.
 
 @param aKey The key for which to return and remove the corresponding value.
 @return The value associated with aKey, or nil if no value is associated with aKey.
 */
- (nullable id)ps_popObjectForKey:(id)aKey;

/**
 Returns a new dictionary containing the entries for keys, and remove these
 entries from receiver. If the keys is empty or nil, it just returns an
 empty dictionary.
 
 @param keys The keys.
 @return The entries for the keys.
 */
- (NSDictionary *)ps_popEntriesForKeys:(NSArray *)keys;

@end


NS_ASSUME_NONNULL_END
