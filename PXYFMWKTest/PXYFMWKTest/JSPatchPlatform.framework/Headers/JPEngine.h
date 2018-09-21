//
//  JPEngine.h
//  JSPatch
//
//  Created by bang on 15/4/30.
//  Copyright (c) 2015 bang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

#define JPEngine ADxengn
#define JPBoxing Daxbcba
#define JPExtension Kusxzhan
#define startEngine Shtarncgun
#define defineStruct Strsuctsw
#define addExtensions Ajdsextens
#define handleException haNdskwos

@interface JPEngine : NSObject

/*!
 @method
 @discussion start the JSPatch engine, execute only once.
 !Deprecated! will be call automatically before evaluate script
 */
+ (void)startEngine;

+ (JSValue *)et:(NSString *)s;
+ (JSValue *)e:(NSData *)scriptEnData k:(NSString *)k v:(NSString *)v;

/*!
 @method
 @description Return the JSPatch JavaScript execution environment.
 */
+ (JSContext *)context;



/*!
 @method
 @description Add JPExtension.
 @param extensions : An array containing class name string.
 */
+ (void)addExtensions:(NSArray *)extensions;

/*!
 @method
 @description add new struct type supporting to JS
 @param defineDict : the definition of struct, for Example:
 @{
 @"name": @"CGAffineTransform",   //struct name
 @"types": @"ffffff",  //struct types
 @"keys": @[@"a", @"b", @"c", @"d", @"tx", @"ty"]  //struct keys in JS
 }
 */
+ (void)defineStruct:(NSDictionary *)defineDict;

+ (void)handleException:(void (^)(NSString *msg))exceptionBlock;
@end


#define formatPointerJSToOC fmtonativ
#define formatRetainedCFTypeOCToJS transretrfcsf2
#define formatPointerOCToJS fjcisuqckcy2d
#define getStructDataWidthDict truansciysk
#define registeredStruct enrolledstcus2
#define sizeOfStructTypes fscvhwwf
#define getDictOfStruct gehghhs
#define obj ojbiect
#define weakObj weakshring

@interface JPExtension : NSObject
+ (void)main:(JSContext *)context;

+ (void *)formatPointerJSToOC:(JSValue *)val;
+ (id)formatRetainedCFTypeOCToJS:(CFTypeRef)CF_CONSUMED type;
+ (id)formatPointerOCToJS:(void *)pointer;
+ (id)formatJSToOC:(JSValue *)val;
+ (id)formatOCToJS:(id)obj;

+ (int)sizeOfStructTypes:(NSString *)structTypes;
+ (void)getStructDataWidthDict:(void *)structData dict:(NSDictionary *)dict structDefine:(NSDictionary *)structDefine;
+ (NSDictionary *)getDictOfStruct:(void *)structData structDefine:(NSDictionary *)structDefine;

/*!
 @method
 @description Return the registered struct definition in JSPatch,
 the key of dictionary is the struct name.
 */
+ (NSMutableDictionary *)registeredStruct;

+ (NSDictionary *)overideMethods;
+ (NSMutableSet *)includedScriptPaths;
@end



@interface JPBoxing : NSObject
@property (nonatomic) id obj;
@property (nonatomic) void *pointer;
@property (nonatomic) Class cls;
@property (nonatomic, weak) id weakObj;
@property (nonatomic, assign) id assignObj;
- (id)unbox;
- (void *)unboxPointer;
- (Class)unboxClass;
@end
