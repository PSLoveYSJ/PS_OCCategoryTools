//
//  NSBundle+PS.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/9.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (PS)

/**
 一个NSNumber对象数组，显示了路径缩放搜索的最佳顺序。
 如iPhone3GS: @ @1、@2 @3] iPhone5: @ [@2、@3 @1] iPhone6 +: @ [@3、@2 @1]
 */
+ (NSArray<NSNumber *> *)ps_preferredScales;
/**
 返回由指定的路径标识的资源文件的完整路径名
 名称和扩展名，并驻留在给定的包目录中。它首先搜索
 当前屏幕大小的文件(例如@2x)，然后从更高的位置搜索
 按比例缩小。
 
 @param name       The name of a resource file contained in the directory
 specified by bundlePath.
 
 @param ext        If extension is an empty string or nil, the extension is
 assumed not to exist and the file is the first file encountered that exactly matches name.
 
 @param bundlePath The path of a top-level bundle directory. This must be a
 valid path. For example, to specify the bundle directory for a Mac app, you
 might specify the path /Applications/MyApp.app.
 
 @return The full pathname for the resource file or nil if the file could not be
 located. This method also returns nil if the bundle specified by the bundlePath
 parameter does not exist or is not a readable directory.
 */
+ (nullable NSString *)ps_pathForScaledResource:(NSString *)name
                                      ofType:(nullable NSString *)ext
                                 inDirectory:(NSString *)bundlePath;

/**
 返回由指定名称和标识的资源的完整路径名
 文件扩展名。它首先搜索当前屏幕大小的文件(如@2x)，
 然后从更高的比例搜索到更低的比例。
 
 @param name       The name of the resource file. If name is an empty string or
 nil, returns the first file encountered of the supplied type.
 
 @param ext        If extension is an empty string or nil, the extension is
 assumed not to exist and the file is the first file encountered that exactly matches name.
 
 
 @return The full pathname for the resource file or nil if the file could not be located.
 */
- (nullable NSString *)ps_pathForScaledResource:(NSString *)name ofType:(nullable NSString *)ext;

/**
 返回由指定名称和标识的资源的完整路径名
 文件扩展名，并位于指定的bundle子目录中。它首先搜索
 当前屏幕大小的文件(例如@2x)，然后从更高的位置搜索
 按比例缩小。
 
 @param name       The name of the resource file.
 
 @param ext        If extension is an empty string or nil, all the files in
 subpath and its subdirectories are returned. If an extension is provided the
 subdirectories are not searched.
 
 @param subpath    The name of the bundle subdirectory. Can be nil.
 
 @return The full pathname for the resource file or nil if the file could not be located.
 */
- (nullable NSString *)ps_pathForScaledResource:(NSString *)name
                                      ofType:(nullable NSString *)ext
                                 inDirectory:(nullable NSString *)subpath;

@end

NS_ASSUME_NONNULL_END
