//
//  PSRunTime.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/16.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSRunTime.h"
#import "PS_Head1.h"
#import "PSBlockModel.h"




@implementation PSRunTime

- (void)ps_getMethod {
//    Class *classes = NULL;
//    unsigned int count = 0;
    PSBlockModel *model = [PSBlockModel new];
    Class class = objc_allocateClassPair([model class], "YSJ", 0);

    objc_registerClassPair(class); // 注册
    Class duplicate = objc_duplicateClass(class, "PS", 0); // 复制Class
//    model.name = @"老婆姚淑娟大大";
//     uint8_t const  *t =  class_getIvarLayout([model class]);
//    class_respondsToSelector([PSBlockModel class], @selector(fuckYSJ));
    DebugLog(@"%@ %@",class,duplicate);
    //    返回一个指向给定类的给定类方法的数据结构的指针
    // class 指向类定义的指针。传递包含要检索的方法的类。
    // SEL 一个类型为\c SEL的指针。传递要检索的方法的选择器。
    // Method 一个指向\c方法数据结构的指针，它对应于实现。
//    *由aClass指定的类指定的选择器，或指定的NULL。
//    *类或其父类不包含具有指定选择器的实例方法。
//    SEL selector = @selector(ps_getMethod);
//    Method method = class_getInstanceMethod([self class], selector);
//    class_addMethod([self class], selector, (IMP)ps_Imp, method_getTypeEncoding(method));
}
- (void)ps_hehe {
    DebugLog(@"funck");
}
static void ps_Imp(id self) {
    
}

#pragma mark &**************** Method method
/**
 * Returns the name of a method.
 * @return A pointer of type SEL.
 * @note To get the method name as a C string, call \c sel_getName(method_getName(method)).
OBJC_EXPORT SEL _Nonnull
method_getName(Method _Nonnull m)
 */

/**
 * 返回方法的实现。
 *
 * @param m The method to inspect.
 *
 * @return A function pointer of type IMP.
OBJC_EXPORT IMP _Nonnull
method_getImplementation(Method _Nonnull m)
 */

/**
 * 返回描述方法参数和返回类型的字符串。
 * @param m The method to inspect.
 * @return A C string. The string may be \c NULL.
OBJC_EXPORT const char * _Nullable
method_getTypeEncoding(Method _Nonnull m)
 */

/**
 * 返回方法所接受的参数的数量。
 *
 * @param m 一个指向\c方法数据结构的指针。把这个方法传下去。
 *
 * @return 包含给定方法所接受的参数数量的整数。
OBJC_EXPORT unsigned int
method_getNumberOfArguments(Method _Nonnull m)
 */

/**
 * 返回描述方法返回类型的字符串。
 * @param m The method to inspect.
 * @return A 描述返回类型的字符串。您必须释放带有\c free()的字符串。
OBJC_EXPORT char * _Nonnull
method_copyReturnType(Method _Nonnull m)
    */

/**
 * 返回描述方法的单个参数类型的字符串。
 * @param m The method to inspect.
 * @param index The index of the parameter to inspect.
 *
 * @return A 在索引\e索引中描述参数类型的字符串，或\ C NULL如果方法没有参数索引\e索引。您必须释放带有\c free()的字符串。
OBJC_EXPORT char * _Nullable
method_copyArgumentType(Method _Nonnull m, unsigned int index)
 */

/**
 * 通过引用一个描述方法返回类型的字符串返回。
 *
 * @param m 您要查询的方法。
 * @param dst The reference string to store the description.
 * @param dst_len The maximum number of characters that can be stored in \e dst.
 *
 * @note 方法的返回类型字符串被复制到\e dst。\e dst被填充，就像调用\c strncpy(dst, parameter_type, dst_len)一样。
OBJC_EXPORT void
method_getReturnType(Method _Nonnull m, char * _Nonnull dst, size_t dst_len)
    */

/**
 * 引用一个字符串，该字符串描述方法的单个参数类型。
 * @param index The index of the parameter you want to inquire about.
 * @param dst 用于存储描述的引用字符串。
 * @param dst_len 可以存储在\e dst中的最大字符数。
 *
 * @note 将参数类型字符串复制到\e dst。\e dst被填充，就像调用\c strncpy(dst, parameter_type, dst_len)一样。如果该方法不包含带有该索引的参数，那么\e dst就会被填满，就像调用\c strncpy(dst，“”，dst_len)一样。
OBJC_EXPORT void
method_getArgumentType(Method _Nonnull m, unsigned int index,
                       char * _Nullable dst, size_t dst_len)
 
 OBJC_EXPORT struct objc_method_description * _Nonnull
 method_getDescription(Method _Nonnull m)
 */

/**
 * Sets the implementation of a method.
 *
 * @param m 用于设置实现的方法。
 * @param imp 设置为该方法的实现。
 *
 * @return 方法的前一个实现。
OBJC_EXPORT IMP _Nonnull
method_setImplementation(Method _Nonnull m, IMP _Nonnull imp)
    */

/**
 * 交换两种方法的实现。
 * @note This is an atomic version of the following:
 *  \code
 *  IMP imp1 = method_getImplementation(m1);
 *  IMP imp2 = method_getImplementation(m2);
 *  method_setImplementation(m1, imp2);
 *  method_setImplementation(m2, imp1);
 *  \endcode
OBJC_EXPORT void
method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2)
 */

#pragma mark &************* SEL method
/**
 OBJC_EXPORT const char * _Nonnull
 sel_getName(SEL _Nonnull sel)
 */

/**
 * 用Objective-C运行时系统注册一个方法，映射方法。
 *名称到选择器，并返回选择器值。
 * @note 您必须使用Objective-C运行时系统注册一个方法名称以获得。
 在将方法添加到类定义之前，方法的选择器。如果方法名称
 *已经注册，这个函数只返回选择器。
OBJC_EXPORT SEL _Nonnull
sel_registerName(const char * _Nonnull str)
 */

/**
 * Returns a Boolean value that indicates whether two selectors are equal.
 *
 * @note sel_isEqual is equivalent to ==.
OBJC_EXPORT BOOL
sel_isEqual(SEL _Nonnull lhs, SEL _Nonnull rhs)
 */

/**
 */

#pragma mark &************* ivar method

/**
 * @return A 包含实例变量名称的C字符串。
OBJC_EXPORT const char * _Nullable
ivar_getName(Ivar _Nonnull v)
 
 */

/**
 * 返回实例变量的偏移量
 *
 * @param v 您要查询的实例变量。
 *
 * @return The offset of \e v.
 *
 * @note 对于类型\c id或其他对象类型的变量，调用\c object_getIvar。和\c object_setIvar，而不是使用这个偏移量直接访问实例变量数据。
OBJC_EXPORT ptrdiff_t
ivar_getOffset(Ivar _Nonnull v)
 */

#pragma mark  &*************** property Method
/**
OBJC_EXPORT const char * _Nonnull
property_getName(objc_property_t _Nonnull property)
 */

/**
 * Returns the attribute string of a property.
 * @note 属性字符串的格式在Objective-C运行时编程指南中的声明属性中被描述。
OBJC_EXPORT const char * _Nullable
property_getAttributes(objc_property_t _Nonnull property)
    */

/**
 * 返回属性的属性属性数组。
 *
 * @param property 您想要复制的属性。
 * @param outCount 数组中返回的属性数。
 *
 * @return An array of property attributes; must be free'd() by the caller.
OBJC_EXPORT objc_property_attribute_t * _Nullable
property_copyAttributeList(objc_property_t _Nonnull property,
                           unsigned int * _Nullable outCount)
       */

/**
 * 返回给定属性名称的属性属性的值。
 * @param property 属性值您感兴趣的属性。
 * @param attributeName C string representing the attribute name.
 * @return 属性\e attributeName的值字符串，如果它存在的话\e属性，否则为nil。
OBJC_EXPORT char * _Nullable
property_copyAttributeValue(objc_property_t _Nonnull property,
                            const char * _Nonnull attributeName)
 */


#pragma mark &************* protocol method

/**
 * @param name The name of a protocol.
 * @return The protocol named \e name, or \c NULL if no protocol named \e name could be found.
 * @note This function acquires the runtime lock.
OBJC_EXPORT Protocol * _Nullable
objc_getProtocol(const char * _Nonnull name)
*/

/**
 * 返回运行时已知的所有协议的数组。
 * @return A C array of all the protocols known to the runtime. The array contains \c *outCount
 *  pointers followed by a \c NULL terminator. You must free the list with \c free().
 *
 * @note 这个函数获得运行时锁。

OBJC_EXPORT Protocol * __unsafe_unretained _Nonnull * _Nullable
objc_copyProtocolList(unsigned int * _Nullable outCount)
 */

/**
 * 返回一个布尔值，该值指示一个协议是否符合另一个协议。
 * @return 如果proto符合其他条件，则不可以。
 *
 * @note 一个协议可以使用相同的语法合并其他协议该类用于采用协议:
 \代码
  @protocol protocol name <协议列表>。
  \ endcode
 尖括号中列出的所有协议都被视为协议名称协议的一部分。
OBJC_EXPORT BOOL
 protocol_conformsToProtocol(Protocol * _Nullable proto,
                            Protocol * _Nullable other)
 */

/**
 * 返回一个布尔值，该值指示两个协议是否相等。

OBJC_EXPORT BOOL
protocol_isEqual(Protocol * _Nullable proto, Protocol * _Nullable other)
*/

/**
 * Returns the name of a protocol.
OBJC_EXPORT const char * _Nonnull
protocol_getName(Protocol * _Nonnull proto)
 
 */

/**
 * 返回给定协议的指定方法的方法描述结构。
 *
 * @param p A protocol.
 * @param aSel A selector.
 * @return An \c objc_method_description结构，它描述了由\e aSel、\e isRequiredMethod和\e isInstanceMethod指定的方法，如果协议不包含指定的方法，则返回\c objc_method_description结构与值\c {NULL， \c NULL}。
 *
 * @note 这个函数递归地搜索这个协议所遵循的任何协议。
OBJC_EXPORT struct objc_method_description
protocol_getMethodDescription(Protocol * _Nonnull proto, SEL _Nonnull aSel,
                              BOOL isRequiredMethod, BOOL isInstanceMethod)
 */

/**
 * 返回一个方法描述的数组，它满足给定协议的给定规范。

 * @return A C数组的\ C objc_method_description结构，其中包含\e p的方法的名称和类型。
 *由isRequiredMethod和\e isInstanceMethod指定。数组包含\c *outCount指针。
 *由一个\c空终止符。您必须使用\c free()来释放该列表。
 *如果协议声明没有满足规范的方法，则返回\c NULL，并且\c *outCount为0。
 *
 * @note 本协议所采用的其他协议中的方法不包括在内。
OBJC_EXPORT struct objc_method_description * _Nullable
protocol_copyMethodDescriptionList(Protocol * _Nonnull proto,
                                   BOOL isRequiredMethod,
                                   BOOL isInstanceMethod,
                                   unsigned int * _Nullable outCount)
 */

/**
 * 返回给定协议的指定属性。

 * @param isRequiredProperty \c YES searches for a required property, \c NO searches for an optional property.
 * @param isInstanceProperty \c YES searches for an instance property, \c NO searches for a class property.
 *
 * @return The property specified by \e name, \e isRequiredProperty, and \e isInstanceProperty for \e proto,
 *  or \c NULL if none of \e proto's properties meets the specification.
OBJC_EXPORT objc_property_t _Nullable
protocol_getProperty(Protocol * _Nonnull proto,
                     const char * _Nonnull name,
                     BOOL isRequiredProperty, BOOL isInstanceProperty)
 */

/**
 * Returns an array of the required instance properties declared by a protocol.
 *
 * @note相同的
 * \代码
 * protocol_copyPropertyList2(proto, outCount, YES, YES);
 * \ endcode
OBJC_EXPORT objc_property_t _Nonnull * _Nullable
protocol_copyPropertyList(Protocol * _Nonnull proto,
                          unsigned int * _Nullable outCount)
 */

/**
 * 返回由协议声明的属性数组。
 * @param isRequiredProperty \c YES returns required properties, \c NO returns optional properties.
 * @param isInstanceProperty \c YES returns instance properties, \c NO returns class properties.
 *
 * @return A C array of pointers of type \c objc_property_t describing the properties declared by \e proto.
 *  Any properties declared by other protocols adopted by this protocol are not included. The array contains
 *  \c *outCount pointers followed by a \c NULL terminator. You must free the array with \c free().
 *  If the protocol declares no matching properties, \c NULL is returned and \c *outCount is \c 0.
OBJC_EXPORT objc_property_t _Nonnull * _Nullable
protocol_copyPropertyList2(Protocol * _Nonnull proto,
                           unsigned int * _Nullable outCount,
                           BOOL isRequiredProperty, BOOL isInstanceProperty)
 */

/**
 * 返回协议所采用的协议的数组。

OBJC_EXPORT Protocol * __unsafe_unretained _Nonnull * _Nullable
protocol_copyProtocolList(Protocol * _Nonnull proto,
                          unsigned int * _Nullable outCount)
 */

/**
 * Creates a new protocol instance that cannot be used until registered with
 * \c objc_registerProtocol()

 * @return 协议实例的成功，\c nil如果一个协议。
 *具有相同的名称。
 * @note 对此没有处理方法。
OBJC_EXPORT Protocol * _Nullable
objc_allocateProtocol(const char * _Nonnull name)

OBJC_EXPORT void
objc_registerProtocol(Protocol * _Nonnull proto)
 */

/**
 * 将方法添加到协议中。协议必须在建设中。
 *
 * @param proto The protocol to add a method to.
 * @param name The name of the method to add.
 * @param types A C string that represents the method signature.
 * @param isRequiredMethod YES if the method is not an optional method.
 * @param isInstanceMethod YES if the method is an instance method.
OBJC_EXPORT void
protocol_addMethodDescription(Protocol * _Nonnull proto, SEL _Nonnull name,
                              const char * _Nullable types,
                              BOOL isRequiredMethod, BOOL isInstanceMethod)
 */

/**
 *向另一个协议添加一个合并的协议。的协议
 添加到必须仍在建设中，而附加议定书。
 必须已经建立。
 *
 * @param proto The protocol you want to add to, it must be under construction.
 * @param addition The protocol you want to incorporate into \e proto, it must be registered.
OBJC_EXPORT void
protocol_addProtocol(Protocol * _Nonnull proto, Protocol * _Nonnull addition)
 
 */

/**
 * 将属性添加到协议。协议必须在建设中。
 * @param attributes An array of property attributes.
 * @param attributeCount The number of attributes in \e attributes.
 * @param isRequiredProperty YES if the property (accessor methods) is not optional.
 * @param isInstanceProperty 是的，如果属性(accessor方法)是实例方法。
 因此，这是唯一允许使用该属性的情况，因此将其设置为NO。
 *不要将属性添加到协议中。
OBJC_EXPORT void
protocol_addProperty(Protocol * _Nonnull proto, const char * _Nonnull name,
                     const objc_property_attribute_t * _Nullable attributes,
                     unsigned int attributeCount,
                     BOOL isRequiredProperty, BOOL isInstanceProperty)
 */


/**
    */
/**
 */
/**
 */
/**
 */


#pragma mark &************* object method
/**
 * 返回对象的class isa
 * @param obj 你想检查的obj
 * @return 返回实例的class
 Class _Nullable
 --------- object_getClass(id _Nullable obj)
  Class class = object_getClass([[PSRunTime new] class]);
  DebugLog(@"%@",NSStringFromClass(class));
 */

/**
 * 返回对象是否为class。
 * @param obj 一个OC 对象
 * @return 如果对象是类或元类，则为false。
 BOOL
 -------- object_isClass(id _Nullable obj)
 BOOL isBool = object_isClass([self class]);
 DebugLog(@"%d",isBool);
 */

/**
 * 设置objc 的class 替换isa
 * @param obj 想要改变的对象
 * @param cls 一个class 对象
 * @return 之前的class 对象 设置完成本类的方法不可调用 isa改变
-------- object_setClass(id _Nullable obj, Class _Nonnull cls)
 Class blockClass = [[PSBlockModel new] class];
 Class setClass = object_setClass(self, blockClass);
 */

/**
 * 读取对象中的实例变量的值。
 * @param obj 该对象包含您想要读取的值的实例变量。
 * @param ivar Ivar描述要读取的值的实例变量。
 * @return 指定的实例变量的值。by \e ivar, or \c nil if \e object is \c nil.
OBJC_EXPORT id _Nullable
-------- object_getIvar(id _Nullable obj, Ivar _Nonnull ivar)
 
 PSBlockModel *model = [PSBlockModel new];
 model.name = @"最爱姚淑娟老婆";
 Ivar ivar = class_getInstanceVariable([model class], "_name");
 id name = object_getIvar(model, ivar);
 */

/**
 * 设置对象中实例变量的值。
 * @param obj objc
 * @param ivar Ivar描述要设置的值的实例变量。
 * @param value 新值
 * @note 具有已知内存管理的实例变量(如强和弱)
 *使用内存管理。具有未知内存管理的实例变量。
 *被指定为未被保留的。
 * @note \c object_setIvar is faster than \c object_setInstanceVariable if the Ivar
 *  for the instance variable is already known.
OBJC_EXPORT void
------ object_setIvar(id _Nullable obj, Ivar _Nonnull ivar, id _Nullable value)
 
 PSBlockModel *model = [PSBlockModel new];
 model.name = @"最爱姚淑娟老婆";
 Ivar ivar = class_getInstanceVariable([model class], "_name");
 object_setIvar(model, ivar, @"我爱老婆大大");
 */

/**
 * 设置对象中实例变量的值
 * @param obj objc
 * @param ivar ivar
 * @param value newvalue
OBJC_EXPORT void
 10.0 之后才能用
object_setIvarWithStrongDefault(id _Nullable obj, Ivar _Nonnull ivar,
                                id _Nullable value)
 */

/**
 * 返回父类
 * @param cls A class object.
 * @return The superclass of the class, or \c Nil if
 *  \e cls is a root class, or \c Nil if \e cls is \c Nil.
 * @note 您通常应该使用\c NSObject的\c超类方法，而不是这个函数。
OBJC_EXPORT Class _Nullable
class_getSuperclass(Class _Nullable cls)
 */


/**
 * 返回Objc 的copy arc 不可用
OBJC_EXPORT id _Nullable object_copy(id _Nullable obj, size_t size)
 * 释放objc 内存 ARC 不可用
OBJC_EXPORT id _Nullable
object_dispose(id _Nullable obj)

 * 更改类实例的实例变量的值。arc 不可使用
 * @param obj 指向类实例的指针。通过对象包含
 您希望修改其值的实例变量。
 * @param name 一个C字符串。传递您希望修改其值的实例变量的名称。
 * @param value newValue
 * @return 一个指向\c Ivar数据结构的指针，它定义了类型和。
 *由\e名称指定的实例变量的名称。
 OBJC_EXPORT Ivar _Nullable
 ------ object_setInstanceVariable(id _Nullable obj, const char * _Nonnull name,
 void * _Nullable value)
 
 OBJC_EXPORT Ivar _Nullable
 object_setInstanceVariableWithStrongDefault(id _Nullable obj,
 const char * _Nonnull name,
 void * _Nullable value)
 // 获取实例属性
 OBJC_EXPORT Ivar _Nullable
 object_getInstanceVariable(id _Nullable obj, const char * _Nonnull name,
 void * _Nullable * _Nullable outValue)

 */

/**
 * Returns the class name of a given object.
 *
 * @param obj An Objective-C object.
 *
 * @return The name of the class of which \e obj is an instance.
OBJC_EXPORT const char * _Nonnull object_getClassName(id _Nullable obj)
 */

/**
 * 将选择器标识为有效或无效。
 * @return YES if selector is valid and has a function implementation, NO otherwise.
 *
 * @warning On some platforms, an invalid reference (to invalid memory addresses) can cause
 *  a crash.
OBJC_EXPORT BOOL sel_isMapped(SEL _Nonnull sel)
 */

/**
 
 */

/**
 
 */

/**
 
 */

/**
 
 */

/**
 
 */

/**
 
 */


#pragma mark &*************** objc method
/**
 * 返回指定类的类定义
 * @param name 要查找的类的名称。.
 * @return 类对象为命名类，或\c nil如果类没有在Objective-C运行时注册。
 * @note \c objc_getClass与\c objc_lookUpClass不同，如果类未注册，\c objc_getClass调用类处理程序回调，然后检查第二次查看该类是否注册。\ c objc_lookUpClass确实
 不要调用类处理程序回调。
OBJC_EXPORT Class _Nullable
------ objc_getClass(const char * _Nonnull name)
 
 Class class = objc_getClass("PSRunTime");
 DebugLog(@"%@",NSStringFromClass(class));
 */

/**
 * 返回指定类的元类定义。 类的实例对象的 isa 指向该类；该类的 isa 指向该类的 metaclass；
 * @param name 类的名称
 * @return 如果类是类的元类，或者\c nil，则\c类对象未在Objective-C运行时注册。
 * @note 如果未注册命名类的定义，则该函数调用类处理程序回调，然后再次检查该类是否已注册。但是，每个类定义都必须有一个有效的元类定义，因此总是返回元类定义，
OBJC_EXPORT Class _Nullable
objc_getMetaClass(const char * _Nonnull name)
 */

/**
 * 返回指定类的类定义。
 * @param name 要查找的类的名称。.
 * @return 类对象为命名类，或\c nil，如果类未在Objective-C运行时注册。
 * @note \c objc_getClass调用类处理程序回调   这个函数不调用类处理程序回调。
OBJC_EXPORT Class _Nullable
------ objc_lookUpClass(const char * _Nonnull name)
*/

/**
 * 返回类的定义
 * @note This function is the same as \c objc_getClass, but kills the process if the class is not found.
 * @note这个函数由ZeroLink使用，没有找到一个类将会是一个编译时的链接错误，没有ZeroLink。
OBJC_EXPORT Class _Nonnull
------ objc_getRequiredClass(const char * _Nonnull name)
 */

/**
 * 获取已注册类定义的列表。
 *
 * @param buffer 一个\c类值的数组。在输出上，每一个\c类值指向一个类定义，最多可以是\e bufferCount或注册类的总数，两者以更少的值为准。您可以通过\c NULL来获得注册类定义的总数，而无需实际检索任何类定义。
 * @param bufferCount 一个整数值。传递已分配空间的指针的数量。在\ e缓冲区。在返回时，这个函数只填充这几个元素。如果这个数字小于注册类的数量，则该函数返回注册类的任意子集。
 * @return 表示注册类总数的整数值。
 * @note Objective-C运行时库会自动注册源代码中定义的所有类 *您可以在运行时创建类定义并将其注册为\c objc_addClass函数。
 
 * @warning 您不能假定您从这个函数中得到的类对象是继承\c NSObject的类，因此您不能安全地调用此类类的任何方法，而不需要检测该方法是先实现的。
OBJC_EXPORT int
 
------ objc_getClassList(Class _Nonnull * _Nullable buffer, int bufferCount)
 
 int count = 0 ;
 int totalCount = objc_getClassList(NULL, 0);
 Class *classes = NULL;
 while (count < totalCount) {
 count = totalCount;
 classes = (Class *)realloc(classes, sizeof(Class) * count);// 申请空间
 totalCount = objc_getClassList(classes, count);
 for (int i = 0; i < totalCount; i++) {
 const char * className = class_getName(classes[i]);
 DebugLog(@"%s",className);
 }
 free(classes);
 }
 */

/**
 * 创建并返回指向所有已注册类定义的指针列表。和差不错objc_getClassList
 * @param outCount 用于存储该函数在列表中返回的类数量的整数指针。它可以是\c nil。
 * @return 无终止的类数组。必须用\c free()释放它。
OBJC_EXPORT Class _Nonnull * _Nullable
objc_copyClassList(unsigned int * _Nullable outCount)
 
 unsigned int count = 0;
 NSMutableArray *array = [NSMutableArray array];
 Class *classes = objc_copyClassList(&count);
 for (int i = 0; i < count; i++) {
 const char *className = class_getName(classes[i]);
 [array addObject:[[NSString alloc] initWithUTF8String:className]];
 }
 free(classes);
 */
/**
 * 创建一个新类和元类。
 * @param superclass 该类用作新类的超类，或\c Nil创建一个新的根类。
 * @param name 用作新类名称的字符串。字符串将被复制。
 * @param extraBytes 在结束时为索引ivars分配的字节数。类和元类对象。这通常是\c 0。
 *
 * @return 如果类不能创建(例如，所需的名称已经在使用中)，则新类或Nil。
 * @note 通过调用\c object_getClass(newClass)，您可以获得一个指向新元类的指针。
 * @note 要创建一个新类，首先调用\c objc_allocateClassPair然后将类的属性设置为\c class_addMethod和\c class_addIvar当您完成构建类时，调用\c objc_registerClassPair。新类现在可以使用了。
 * @note 实例方法和实例变量应该添加到类本身中。
 * 类方法应该添加到元类中。
OBJC_EXPORT Class _Nullable
objc_allocateClassPair(Class _Nullable superclass, const char * _Nonnull name,
                       size_t extraBytes)
 */


/**
 * Registers a class that was allocated using \c objc_allocateClassPair.
 *
 * @param cls The class you want to register.
OBJC_EXPORT void
objc_registerClassPair(Class _Nonnull cls)
OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);
 */

/**
 * Used by Foundation's Key-Value Observing.
 *
 * @warning Do not call this function yourself.
OBJC_EXPORT Class _Nonnull
objc_duplicateClass(Class _Nonnull original, const char * _Nonnull name,
                    size_t extraBytes)
 */

/**
 * 销毁一个类及其相关的元类。
 *
 * @param cls 要销毁的类。它一定是被分配的\ c objc_allocateClassPair
 *
 * @warning Do not call if instances of this class or a subclass exist.
OBJC_EXPORT void
objc_disposeClassPair(Class _Nonnull cls)
 */

/**
返回所有已加载的Objective-C框架和动态库的名称。

 * @return An array of C strings of names. Must be free()'d by caller.
OBJC_EXPORT const char * _Nonnull * _Nonnull
objc_copyImageNames(unsigned int * _Nullable outCount)
 
 */

/**
 *返回一个类的动态库名称。
 *
 * @param cls 你要询问的课程。
OBJC_EXPORT const char * _Nullable
class_getImageName(Class _Nullable cls)
 */

/**
 * 返回一个库中所有类的名称。
 *
 * @param image 你要查询的图书馆或框架。
 * @param outCount The number of class names returned.
 *
 * @return An array of C strings representing the class names.
OBJC_EXPORT const char * _Nonnull * _Nullable
objc_copyClassNamesForImage(const char * _Nonnull image,
                            unsigned int * _Nullable outCount)
*/

/**
当在foreach迭代中检测到一个突变时，该函数被编译器插入。当发生一个突变时，它就会被调用，并且如果它被设置的话，枚举mutationhandler就会被执行。如果没有设置处理程序，就会发生致命错误。
 *
 * @param obj The object being mutated.
OBJC_EXPORT void
objc_enumerationMutation(id _Nonnull obj)
 */

/**
 * Sets the current mutation handler.
 *
 * @param handler Function pointer to the new mutation handler.
OBJC_EXPORT void
objc_setEnumerationMutationHandler(void (*_Nullable handler)(id _Nonnull ))
 */

/**
 * Set the function to be called by objc_msgForward.
 * @see message.h::_objc_msgForward
OBJC_EXPORT void
objc_setForwardHandler(void * _Nonnull fwd, void * _Nonnull fwd_stret)
 */

/**
 * 使用给定的键和关联策略为给定对象设置关联值。
 *
 * @param object The source object for the association.
 * @param key The key for the association.
 * @param value The value to associate with the key key for object. Pass nil to clear an existing association.
 * @param policy The policy for the association. For possible values, see “Associative Object Behaviors.”
OBJC_EXPORT void
objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,
                         id _Nullable value, objc_AssociationPolicy policy)
 */

/**
 * 返回给定键的给定对象关联的值。
OBJC_EXPORT id _Nullable
objc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)
 */

/**
 * Removes all associations for a given object.

 * @note 这个函数的主要目的是使对象返回到“原始状态”变得容易。您不应该使用此函数来一般地删除对象之间的关联，因为它也删除了其他客户可能添加到对象中的关联。通常，您应该使用\c objc_setAssociatedObject，以空值来清除关联。

OBJC_EXPORT void
objc_removeAssociatedObjects(id _Nonnull object)
 */

/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */
/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

#pragma mark &*************** imp method

/**
 * 创建一个指向函数的指针，该函数在调用该方法时将调用该块。
 *
 * @param block 实现此方法的块。其签名应该是:method_return_type ^(id自我,method_args…)。选择器不能作为这个块的参数可用。该块使用\c Block_copy()复制。
 *
 * @return The IMP that calls this block. Must be disposed of with
 *  \c imp_removeBlock.
OBJC_EXPORT IMP _Nonnull
imp_implementationWithBlock(id _Nonnull block)
 */

/**
 *返回使用\c imp_implementationWithBlock创建的与IMP关联的块。
 * @return The block called by \e anImp.
OBJC_EXPORT id _Nullable
imp_getBlock(IMP _Nonnull anImp)
 */

/**
 * 从使用\c imp_implementationWithBlock创建的IMP中分离一个块，并释放创建的块的副本。
 *
 * @param anImp An IMP that was created using \c imp_implementationWithBlock.
 * @return YES if the block was released successfully, NO otherwise.
 *  (For example, the block might not have been used to create an IMP previously).
OBJC_EXPORT BOOL
imp_removeBlock(IMP _Nonnull anImp)
 */

/**
 * 这将加载一个弱指针引用的对象并返回它，在保留和自动调整对象之后，以确保调用者能够使用它。在表达式中使用__weak变量时将使用该函数。
 *
 * @param location The weak pointer address
 *
 * @return The object pointed to by \e location, or \c nil if \e *location is \c nil.
OBJC_EXPORT id _Nullable
objc_loadWeak(id _Nullable * _Nonnull location)
 */

/**
 * 该函数将一个新值存储到__weak变量中。它将被用于任何一个__weak变量是任务的目标。
 * @param location The address of the weak pointer itself
 * @param obj The new object this weak ptr should now point to
 * @return 该值存储在\e位置，即\e obj。
OBJC_EXPORT id _Nullable
objc_storeWeak(id _Nullable * _Nonnull location, id _Nullable obj)
 */

/**
 * Policies related to associative references.
 * These are options to objc_setAssociatedObject()
typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
    OBJC_ASSOCIATION_ASSIGN = 0,          < Specifies a weak reference to the associated object.
    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, < Specifies a strong reference to the associated object.
                                            *   The association is not made atomically.
    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   < Specifies that the associated object is copied.
                                            *   The association is not made atomically.
    OBJC_ASSOCIATION_RETAIN = 01401,       < Specifies a strong reference to the associated object.
                                            *   The association is made atomically.
    OBJC_ASSOCIATION_COPY = 01403          < Specifies that the associated object is copied.
                                            *   The association is made atomically.
};
 */


#pragma mark &*************** class method

/**
 * 返回class 的name
 * @param cls class object
 * @return 类的名称或空字符串如果\e cls是\c Nil。
 
 OBJC_EXPORT const char * _Nonnull
 class_getName(Class _Nullable cls)
 */

/**
 *指示类对象是否为元类的布尔值。
 * @param cls class object
 * @return \c YES if \e cls is a metaclass, \c NO if \e cls is a non-meta class,
 *  \c NO if \e cls is \c Nil.
OBJC_EXPORT BOOL
class_isMetaClass(Class _Nullable cls)
 */

/**
 * Returns 类定义的版本号。
 * @param cls 一个指向\c类数据结构的指针。传递您希望获得版本的类定义。
 * @return 指示类定义的版本号的整数。
OBJC_EXPORT int
class_getVersion(Class _Nullable cls)
 */

/**
 * 对一个类设置version 版本号
 *
 * @param cls 指向类数据结构的指针。传递您希望设置版本的类定义。
 * @param version An integer. Pass the new version number of the class definition.
 *
 * @note 您可以使用类定义的版本号来提供版本控制您的类代表其他类的接口这对于对象来说特别有用序列化(也就是说，将对象以扁平的形式存档)，在那里它很重要识别不同类别定义版本中实例变量布局的更改。
 * @note 派生自Foundation框架\c NSObject类的类可以设置类定义。
 *版本号使用\c setVersion:类方法，使用\c class_setVersion函数实现。
OBJC_EXPORT void
class_setVersion(Class _Nullable cls, int version)
 */

/**
 * 返回类实例的大小。
 * @param cls class Object
OBJC_EXPORT size_t
class_getInstanceSize(Class _Nullable cls)
    */

/**
 * 返回给定类的指定实例变量的\c Ivar。
 * @param cls class
 * @param name name.
 *
 * @return 指向一个包含有关信息的\c Ivar数据结构的指针。由\e名称指定的实例变量。
OBJC_EXPORT Ivar _Nullable
class_getInstanceVariable(Class _Nullable cls, const char * _Nonnull name)
 
 Ivar ivar = class_getInstanceVariable([[PSBlockModel new] class], "_name");
 DebugLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
 */

/**
 * 返回给定类的指定类变量的Ivar。
 * @param cls class object
 * @param name 要获取的类变量定义的名称。
 * @return 一个指向\c Ivar数据结构的指针，它包含了由\e名称指定的类变量的信息。
OBJC_EXPORT Ivar _Nullable
class_getClassVariable(Class _Nullable cls, const char * _Nonnull name)
 */

/**
 * 描述类声明的实例变量。
 * @param cls class
 * @param outCount On return，包含返回的数组的长度。如果outCount为空，则不返回长度。
 * @return 描述类声明的实例变量的Ivar类型的指针数组。超类声明的任何实例变量都不包括在内。数组包含*outCount指针，后跟一个空终止符。您必须使用free()释放数组。
 *
 *  如果类声明没有实例变量，或cls为Nil，则返回NULL，并且*outCount为0。
OBJC_EXPORT Ivar _Nonnull * _Nullable
 ------ class_copyIvarList(Class _Nullable cls, unsigned int * _Nullable outCount)
 */

/**
 * @return 对应于指定的选择器的实现的方法。
 如果指定的类或其指定的类，则由\e cls或\c NULL指定的类的名称。
 *父类不包含指定选择器的实例方法。
 * @note 这个函数在超类中搜索实现，而\c class_copyMethodList没有。
OBJC_EXPORT Method _Nullable
class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name)
 */

/**
 * 返回一个指向给定类的给定类方法的数据结构的指针。
OBJC_EXPORT Method _Nullable
class_getClassMethod(Class _Nullable cls, SEL _Nonnull name)
 */

/**
 * 返回一个函数指针，如果一个特定的消息被发送到一个类的实例，该指针将被调用。
 * @return 如果调用\c[对象名称]，则调用函数指针有一个类的实例，或者\c为空，如果cls是\c Nil。
 * @note \c class_getMethodImplementation may be faster than \c method_getImplementation(class_getInstanceMethod(cls, name)).
 * @note 返回的函数指针可能是运行时的函数，而不是实际的方法实现。例如，如果类的实例没有响应选择器，返回的函数指针将是运行时的消息转发机制的一部分。
OBJC_EXPORT IMP _Nullable
class_getMethodImplementation(Class _Nullable cls, SEL _Nonnull name)
 */

/**
 * Returns the function pointer that would be called if a particular message were sent to an instance of a class.

OBJC_EXPORT IMP _Nullable
class_getMethodImplementation_stret(Class _Nullable cls, SEL _Nonnull name)
 */

/**
 * 返回一个布尔值，该值指示类的实例是否响应特定的选择器。
 * @note 您通常应该使用\c NSObject的\c respondsToSelector:或\c instancesRespondToSelector:方法而不是这个函数。
OBJC_EXPORT BOOL
class_respondsToSelector(Class _Nullable cls, SEL _Nonnull sel)
 */

/**
 * @note You should usually use NSObject's conformsToProtocol: method instead of this function.
// 符合 Protocol
OBJC_EXPORT BOOL
class_conformsToProtocol(Class _Nullable cls, Protocol * _Nullable protocol)
 */

/**
 *描述类所采用的协议。
 * @return 一组类型协议的指针*描述所采用的协议类。任何超类或其他协议所采用的协议都不包括在内数组包含*outCount指针，后跟一个空终止符。您必须使用free()释放数组。
OBJC_EXPORT Protocol * __unsafe_unretained _Nonnull * _Nullable
class_copyProtocolList(Class _Nullable cls, unsigned int * _Nullable outCount)
 */

/**
 * 返回给定类的给定名称的属性。
 * @return 用于描述属性的类型\c objc_property_t的指针\c，如果类不声明具有该名称的属性，如果cls是\c Nil，则为零。
OBJC_EXPORT objc_property_t _Nullable
class_getProperty(Class _Nullable cls, const char * _Nonnull name)
 */

/**
 * @return 描述属性的类型\c objc_property_t的指针数组。
 *由班级声明。超类声明的任何属性都不包括在内。
 *数组包含\c *outCount指针，后跟一个\c NULL结束符。您必须使用\c free()释放数组。
OBJC_EXPORT objc_property_t _Nonnull * _Nullable
class_copyPropertyList(Class _Nullable cls, unsigned int * _Nullable outCount)
*/

/**
 * 返回给定类的\c Ivar布局的描述。
OBJC_EXPORT const uint8_t * _Nullable
class_getIvarLayout(Class _Nullable cls)
 
      uint8_t const  *t =  class_getIvarLayout([model class]);
 */

/**
 * 返回一个给定类的弱Ivars布局的描述。
OBJC_EXPORT const uint8_t * _Nullable
class_getWeakIvarLayout(Class _Nullable cls)
*/

/**
 * 向具有给定名称和实现的类添加新方法
 *
 * @param cls class
 * @param name 指定要添加的方法名称的选择器。
 * @param imp 一个函数，它是新方法的实现。这个函数至少需要两个参数——self和_cmd。
 * @param types 一组字符，用来描述方法参数的类型。
 *
 * @return YES 如果方法成功地添加了，否则没有(例如，该类已经包含了使用该名称的方法实现)。
 *
 * @note class_addMethod将添加超类实现的覆盖，
 但是在这个类中不会替换现有的实现。
 要更改现有的实现，请使用method_setImplementation。
OBJC_EXPORT BOOL
class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
                const char * _Nullable types)
 */

/**
 * 替换给定类的方法的实现。
 *
 * @param cls The class you want to modify.
 * @param name 一个选择器，它标识要替换的方法的实现。
 * @param imp 由cls标识的类所标识的方法的新实现。
 * @param types 一组字符，用来描述方法参数的类型由于该函数必须至少包含两个arguments-self和_cmd，第二个和第三个字符必须是“@:”(第一个字符是返回类型)。
 *
 * @return 前一种方法的实现，该方法由\e cls识别的类命名。
 *
 * @note 这个函数的表现方式有两种:
 * -如果以\e名称标识的方法还不存在，就会添加它，就像调用\c class_addMethod一样。
 *使用\e类型指定的类型编码。
 * -如果以\e名称标识的方法确实存在，那么它的\c IMP就会被替换为\c method_setImplementation被调用。
 *忽略了\e类型指定的类型编码。
OBJC_EXPORT IMP _Nullable
-- class_replaceMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
                    const char * _Nullable types)
    */

/**
 * 向类中添加一个新的实例变量。
 * 如果成功添加了实例变量，则返回YES，否则不会。
 (例如，该类已经包含了一个具有该名称的实例变量)。
 *
 * @note 函数只能在objc_allocateClassPair和objc_registerClassPair之前调用。
 *不支持向现有类添加实例变量。
 * @note 类不能是元类。不支持将实例变量添加到元类。
 * @note 实例变量的最小对齐方式是1<<align。实例的最小对齐。
 *变量取决于ivar的类型和机器架构。
 *对于任何指针类型的变量，通过log2(sizeof(pointer_type))。
OBJC_EXPORT BOOL
class_addIvar(Class _Nullable cls, const char * _Nonnull name, size_t size,
              uint8_t alignment, const char * _Nullable types)
 */


/**
 * Adds a protocol to a class.
 * @return 如果方法被成功添加，则是(例如，该类已经符合该协议)。
OBJC_EXPORT BOOL
class_addProtocol(Class _Nullable cls, Protocol * _Nonnull protocol)
    */

/**
 * Adds a property to a class.
 * @param cls The class to modify.
 * @param name 属性的名称。
 * @param attributes 属性的数组。
 * @param attributeCount 属性在\e属性中的数量。

OBJC_EXPORT BOOL
class_addProperty(Class _Nullable cls, const char * _Nonnull name,
                  const objc_property_attribute_t * _Nullable attributes,
                  unsigned int attributeCount)
 */

/**
 * Replace a property of a class.
 * @param cls The class to modify.
 * @param name The name of the property.
 * @param attributes An array of property attributes.
 * @param attributeCount The number of attributes in \e attributes.
OBJC_EXPORT void
class_replaceProperty(Class _Nullable cls, const char * _Nonnull name,
                      const objc_property_attribute_t * _Nullable attributes,
                      unsigned int attributeCount)
*/

/**
OBJC_EXPORT void
class_setIvarLayout(Class _Nullable cls, const uint8_t * _Nullable layout)
OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);
 */

/**
 * Sets the layout for weak Ivars for a given class.
 * @param cls The class to modify.
 * @param layout The layout of the weak Ivars for \e cls.
OBJC_EXPORT void
class_setWeakIvarLayout(Class _Nullable cls, const uint8_t * _Nullable layout)
    */

/**
 * 创建一个类的实例，在默认的malloc内存区域中为该类分配内存。
 * @param extraBytes 表示要分配的额外字节数的整数。可以使用额外的字节来存储超出类定义定义的其他实例变量。
OBJC_EXPORT id _Nullable
class_createInstance(Class _Nullable cls, size_t extraBytes)
OBJC_RETURNS_RETAINED
 */

/**
    
*/
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */

/**
 
 */
/**
 
 */



/**
 设置超类  已经弃用
 Class _Nonnull
 class_setSuperclass(Class _Nonnull cls, Class _Nonnull newSuper)
 
OBJC_EXPORT Class _Nonnull
objc_getFutureClass(const char * _Nonnull name)
 
 * 在提供的特定位置创建一个类的实例。.
 * @see class_createInstance
OBJC_EXPORT id _Nullable
objc_constructInstance(Class _Nullable cls, void * _Nullable bytes)
 
 * 销毁类的实例而不释放内存，并删除该实例可能具有的任何相关引用。

 * @note CF and other clients do call this under GC.
OBJC_EXPORT void * _Nullable objc_destructInstance(id _Nullable obj)
 
 */

#pragma mark &************* struct
/**
// struct objc_method_description_list {
// int count;
// struct objc_method_description list[1];
// };
//
//
// struct objc_protocol_list {
// struct objc_protocol_list * _Nullable next;
// long count;
// __unsafe_unretained Protocol * _Nullable list[1];
// };
//
//
// struct objc_category {
// char * _Nonnull category_name                            OBJC2_UNAVAILABLE;
// char * _Nonnull class_name                               OBJC2_UNAVAILABLE;
// struct objc_method_list * _Nullable instance_methods     OBJC2_UNAVAILABLE;
// struct objc_method_list * _Nullable class_methods        OBJC2_UNAVAILABLE;
// struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
// }                                                            OBJC2_UNAVAILABLE;
//
//
// struct objc_ivar {
// char * _Nullable ivar_name                               OBJC2_UNAVAILABLE;
// char * _Nullable ivar_type                               OBJC2_UNAVAILABLE;
// int ivar_offset                                          OBJC2_UNAVAILABLE;
// #ifdef __LP64__
// int space                                                OBJC2_UNAVAILABLE;
// #endif
// }                                                            OBJC2_UNAVAILABLE;
//
// struct objc_ivar_list {
// int ivar_count                                           OBJC2_UNAVAILABLE;
// #ifdef __LP64__
// int space                                                OBJC2_UNAVAILABLE;
// #endif
//  variable length structure 
//struct objc_ivar ivar_list[1]                            OBJC2_UNAVAILABLE;
//}                                                            OBJC2_UNAVAILABLE;
//
//
//struct objc_method {
//    SEL _Nonnull method_name                                 OBJC2_UNAVAILABLE;
//    char * _Nullable method_types                            OBJC2_UNAVAILABLE;
//    IMP _Nonnull method_imp                                  OBJC2_UNAVAILABLE;
//}                                                            OBJC2_UNAVAILABLE;
//
//struct objc_method_list {
//    struct objc_method_list * _Nullable obsolete             OBJC2_UNAVAILABLE;
//
//    int method_count                                         OBJC2_UNAVAILABLE;
//#ifdef __LP64__
//    int space                                                OBJC2_UNAVAILABLE;
//#endif
//    /* variable length structure */
//    struct objc_method method_list[1]                        OBJC2_UNAVAILABLE;
//}                                                            OBJC2_UNAVAILABLE;
//
//
//typedef struct objc_symtab *Symtab                           OBJC2_UNAVAILABLE;

//struct objc_symtab {
//    unsigned long sel_ref_cnt                                OBJC2_UNAVAILABLE;
//    SEL _Nonnull * _Nullable refs                            OBJC2_UNAVAILABLE;
//    unsigned short cls_def_cnt                               OBJC2_UNAVAILABLE;
//    unsigned short cat_def_cnt                               OBJC2_UNAVAILABLE;
//    void * _Nullable defs[1] /* variable size */             OBJC2_UNAVAILABLE;
//}                                                            OBJC2_UNAVAILABLE;


//typedef struct objc_cache *Cache                             OBJC2_UNAVAILABLE;

//#define CACHE_BUCKET_NAME(B)  ((B)->method_name)
//#define CACHE_BUCKET_IMP(B)   ((B)->method_imp)
//#define CACHE_BUCKET_VALID(B) (B)
//#ifndef __LP64__
//#define CACHE_HASH(sel, mask) (((uintptr_t)(sel)>>2) & (mask))
//#else
//#define CACHE_HASH(sel, mask) (((unsigned int)((uintptr_t)(sel)>>3)) & (mask))
//#endif
//struct objc_cache {
//    unsigned int mask /* total = mask + 1 */                 OBJC2_UNAVAILABLE;
//    unsigned int occupied                                    OBJC2_UNAVAILABLE;
//    Method _Nullable buckets[1]                              OBJC2_UNAVAILABLE;
//};
//
//
//typedef struct objc_module *Module                           OBJC2_UNAVAILABLE;
//
//struct objc_module {
//    unsigned long version                                    OBJC2_UNAVAILABLE;
//    unsigned long size                                       OBJC2_UNAVAILABLE;
//    const char * _Nullable name                              OBJC2_UNAVAILABLE;
//    Symtab _Nullable symtab                                  OBJC2_UNAVAILABLE;
//}                                                            OBJC2_UNAVAILABLE;
//
//
//
//struct objc_method_list;

///// An opaque type that represents a method in a class definition.
//typedef struct objc_method *Method;
//
///// An opaque type that represents an instance variable.
//typedef struct objc_ivar *Ivar;
//
///// An opaque type that represents a category.
//typedef struct objc_category *Category;
//
///// An opaque type that represents an Objective-C declared property.
//typedef struct objc_property *objc_property_t;
//
//struct objc_class {
//    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
//
//#if !__OBJC2__
//    Class _Nullable super_class                              OBJC2_UNAVAILABLE;
//    const char * _Nonnull name                               OBJC2_UNAVAILABLE;
//    long version                                             OBJC2_UNAVAILABLE;
//    long info                                                OBJC2_UNAVAILABLE;
//    long instance_size                                       OBJC2_UNAVAILABLE;
//    struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE;
//    struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;
//    struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE;
//    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
//#endif
//
//} OBJC2_UNAVAILABLE;
///* Use `Class` instead of `struct objc_class *` */
//
//#endif
//
//#ifdef __OBJC__
//@class Protocol;
//#else
//typedef struct objc_object Protocol;
//#endif
//
///// Defines a method
//struct objc_method_description {
//    SEL _Nullable name;               /**< The name of the method */
//    char * _Nullable types;           /**< The types of the method arguments */
//};
//
///// Defines a property attribute
//typedef struct {
//    const char * _Nonnull name;           /**< The name of the attribute */
//    const char * _Nonnull value;          /**< The value of the attribute (usually empty) */
//} objc_property_attribute_t;

 
// */

@end
