//
//  NSData+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/3.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (PS)


#pragma mark &************ Hash

/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)ps_md2String;

/**
 Returns an NSData for md2 hash.
 */
- (NSData *)ps_md2Data;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)ps_md4String;

/**
 Returns an NSData for md4 hash.
 */
- (NSData *)ps_md4Data;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)ps_md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)ps_md5Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)ps_sha1String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)ps_sha1Data;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)ps_sha224String;

/**
 Returns an NSData for sha224 hash.
 */
- (NSData *)ps_sha224Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)ps_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)ps_sha256Data;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)ps_sha384String;

/**
 Returns an NSData for sha384 hash.
 */
- (NSData *)ps_sha384Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)ps_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)ps_sha512Data;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)ps_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSData *)ps_hmacMD5DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)ps_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)ps_hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSString *)ps_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSData *)ps_hmacSHA224DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSString *)ps_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSData *)ps_hmacSHA256DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSString *)ps_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSData *)ps_hmacSHA384DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSString *)ps_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSData *)ps_hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)ps_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)ps_crc32;


#pragma mark &************ Encrypt and Decrypt

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (nullable NSData *)ps_aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)ps_aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;


#pragma mark &************ Encode and decode

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)ps_utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)ps_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)ps_dataWithHexString:(NSString *)hexString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id) ps_jsonValueDecoded;

/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)ps_base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)ps_dataWithBase64EncodedString:(NSString *)base64EncodedString;


#pragma mark &************ Inflate and deflate

/**
 Decompress data from gzip data.
 @return Inflated data.
 */
- (nullable NSData *)ps_gzipInflate;

/**
 Comperss data to gzip in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)ps_gzipDeflate;

/**
 Decompress data from zlib-compressed data.
 @return Inflated data.
 */
- (nullable NSData *)ps_zlibInflate;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)ps_zlibDeflate;


#pragma mark &************ Others

/**
 Create data from the file in main bundle (similar to [UIImage imageNamed:]).
 
 @param name The file name (in main bundle).
 
 @return A new data create from the file.
 */
+ (nullable NSData *)ps_dataNamed:(NSString *)name;


@end

NS_ASSUME_NONNULL_END
