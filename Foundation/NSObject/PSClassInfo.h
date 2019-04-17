//
//  PSClassInfo.h
//  PSOCStudy
//
//  Created by Peng on 2019/1/9.
//  Copyright © 2019 PengShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, PSEncodingType) {
    PSEncodingTypeMask       = 0xFF, ///< mask of type value
    PSEncodingTypeUnknown    = 0, ///< unknown
    PSEncodingTypeVoid       = 1, ///< void
    PSEncodingTypeBool       = 2, ///< bool
    PSEncodingTypeInt8       = 3, ///< char / BOOL
    PSEncodingTypeUInt8      = 4, ///< unsigned char
    PSEncodingTypeInt16      = 5, ///< short
    PSEncodingTypeUInt16     = 6, ///< unsigned short
    PSEncodingTypeInt32      = 7, ///< int
    PSEncodingTypeUInt32     = 8, ///< unsigned int
    PSEncodingTypeInt64      = 9, ///< long long
    PSEncodingTypeUInt64     = 10, ///< unsigned long long
    PSEncodingTypeFloat      = 11, ///< float
    PSEncodingTypeDouble     = 12, ///< double
    PSEncodingTypeLongDouble = 13, ///< long double
    PSEncodingTypeObject     = 14, ///< id
    PSEncodingTypeClass      = 15, ///< Class
    PSEncodingTypeSEL        = 16, ///< SEL
    PSEncodingTypeBlock      = 17, ///< block
    PSEncodingTypePointer    = 18, ///< void*
    PSEncodingTypeStruct     = 19, ///< struct
    PSEncodingTypeUnion      = 20, ///< union
    PSEncodingTypeCString    = 21, ///< char*
    PSEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    PSEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    PSEncodingTypeQualifierConst  = 1 << 8,  ///< const
    PSEncodingTypeQualifierIn     = 1 << 9,  ///< in
    PSEncodingTypeQualifierInout  = 1 << 10, ///< inout
    PSEncodingTypeQualifierOut    = 1 << 11, ///< out
    PSEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    PSEncodingTypeQualifierByref  = 1 << 13, ///< byref
    PSEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    PSEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    PSEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    PSEncodingTypePropertyCopy         = 1 << 17, ///< copy
    PSEncodingTypePropertyRetain       = 1 << 18, ///< retain
    PSEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    PSEncodingTypePropertyWeak         = 1 << 20, ///< weak
    PSEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    PSEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    PSEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
PSEncodingType PSEncodingGetType(const char *typeEncoding);


/**
 Instance variable information.
 */
@interface PSClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              ///< ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) PSEncodingType type;    ///< Ivar's type

/**
 Creates and returns an ivar info object.
 
 @param ivar ivar opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 Method information.
 */
@interface PSClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;                  ///< method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nonatomic, assign, readonly) IMP imp;                        ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of arguments' type

/**
 Creates and returns a method info object.
 
 @param method method opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithMethod:(Method)method;
@end


/**
 Property information.
 */
@interface PSClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property's opaque struct
@property (nonatomic, strong, readonly) NSString *name;           ///< property's name
@property (nonatomic, assign, readonly) PSEncodingType type;      ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;       ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;      ///< may be nil
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; ///< may nil
@property (nonatomic, assign, readonly) SEL getter;               ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter;               ///< setter (nonnull)

/**
 Creates and returns a property info object.
 
 @param property property opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithProperty:(objc_property_t)property;
@end


/**
 Class information for a class.
 */
@interface PSClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) PSClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, PSClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, PSClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, PSClassPropertyInfo *> *propertyInfos; ///< properties

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, `needUpdate` will returns `YES`, and you should call
 'classInfoWithClass' or 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`, you should stop using this instance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
