//
//  NSObject+PXYKVO.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/7.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "NSObject+PXYKVO.h"
#import <objc/message.h>

#define PXYKVOClassPrefix @"PXYKVONotifying_"

// 字典的 Key
#define PXYKVODic_Observer @"PXYKVODic_Observer"
#define PXYKVODic_Key @"PXYKVODic_Key"
#define PXYKVODic_Block @"PXYKVODic_Block"

//存放 观察者数据的 数组
const void * PXYKVODictArrayKey = @"PXYKVODictArrayKey";

@implementation NSObject (PXYKVO)

/**
 添加 KVO Block
 */
- (void)pxy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath completeBlock:(PXYKVOCompleteBlock)completeBlock {
    //1.检查原始类，是否存在 KeyPath 对应的 Setter 方法
    //1.1 获取属性的 setter 方法名
    NSString *setterSelName = [self p_fetchSetterSelNameWithKey:keyPath];
    SEL setterSEL = NSSelectorFromString(setterSelName);
    
    //1.2 获取该方法
    Method setterMethod = class_getInstanceMethod([self class], setterSEL);
    
    //1.3 无该方法实现
    if (setterMethod == NULL) {
        
        return;
    }
    
    //2.有setter方法实现, 继续检查对象的isa指针是否指向我们自己派生的子类
    Class currentClass = object_getClass(self);
    NSString *currentClassName = NSStringFromClass(currentClass);
    
    //此时还没有派生子类
    if (![currentClassName hasPrefix:PXYKVOClassPrefix]) {
       //派生自己的子类
        currentClass = [self pxy_fetchPXYKVOClassWithOriginalClassName:currentClassName];
        
        //修改当前类的isa指针
        object_setClass(self, currentClass);
    }
    
    //3.重写派生的子类 对象属性的setter方法
    const char *type = method_getTypeEncoding(setterMethod);
    class_addMethod(currentClass, setterSEL, (IMP)KVOClass_ObserveKeySetterIMP, type);
    
    //4.保存该观察者到 观察者数组中
    //4.1 创建储存这个观察者的信息的字典
    NSMutableDictionary *singleKVODic = [NSMutableDictionary dictionary];
    singleKVODic[PXYKVODic_Observer] = observer;
    singleKVODic[PXYKVODic_Key] = keyPath;
    singleKVODic[PXYKVODic_Block] = completeBlock;
    
    //4.2 获取关联 装有所有监听者的 数组
    NSMutableArray *KVODictArray = objc_getAssociatedObject(self, PXYKVODictArrayKey);
    if (KVODictArray == nil) {
        KVODictArray = [NSMutableArray array];
        objc_setAssociatedObject(self, PXYKVODictArrayKey, KVODictArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //4.3 添加该观察者
    [KVODictArray addObject:singleKVODic];
}

/**
 移除 KVO Block
 */
- (void)pxy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    //1.获取观察者数组
    NSMutableArray *KVODictArray = objc_getAssociatedObject(self, PXYKVODictArrayKey);
    if (KVODictArray == nil) return;
    
    for (NSDictionary *KVODict in KVODictArray) {
        if ([KVODict[PXYKVODic_Key] isEqualToString:keyPath]) {
            /* !!!: 这里需要确认，这样子移除不会 Crash ？ */
            [KVODictArray removeObject:KVODict];
            break;
        }
    }
}

#pragma mark - Private Methods
/**
 将 key 转成 setter 方法
 */
- (NSString *)p_fetchSetterSelNameWithKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }
    
    //1.首字母转换成大写
    NSString *firstUpStr = [NSString stringWithFormat:@"%c",[[key uppercaseString] characterAtIndex:0]];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstUpStr];
    
    //2.前面加set
    NSString *setterMethodName = [NSString stringWithFormat:@"set%@:",key];
    
    //3.返回setter方法名
    return setterMethodName;
}

/**
 根据setter方法名,获取getter方法名
 */
- (NSString *)p_fetchGetterSELNameWithSetterSELName:(NSString *)setterSELName {
    ////1.去掉set
    NSRange range = [setterSELName rangeOfString:@"set"];
    NSString *subStr = [setterSELName substringFromIndex:range.length];
    
    //2.首字母转换成小写
    NSString *firstDownStr = [NSString stringWithFormat:@"%c",[[subStr lowercaseString] characterAtIndex:0]];
    NSString *getterSELName = [subStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstDownStr];
    
    //3.去掉最后的:
    getterSELName = [getterSELName substringToIndex:subStr.length - 1];
    return getterSELName;
}


Class PXYKVOClass_ClassIMP (id self, SEL cmd) {
    //该方法是由添加观察者时,修改了class的实现,且由外部调用,当能来到这个方法时,isa已指向自己派生出来的子类了,
    //所以此时的self为派生类
    Class KVOClass = object_getClass(self);
    
    //由于派生的是子类,所以此时的self的父类为原始的类
    Class KVOClassSuperClass = class_getSuperclass(KVOClass);
    
    return KVOClassSuperClass;
}

/**
 获取派生的类名
 */
- (Class)pxy_fetchPXYKVOClassWithOriginalClassName:(NSString *)originalClassName {
    //1.获取将要派生的KVOClass的类名
    NSString *KVOClassName = [PXYKVOClassPrefix stringByAppendingString:originalClassName];
    Class KVOClass = NSClassFromString(KVOClassName);
    
    //2.检测KVOClass类是否已经被注册
    //2.1 KVOClass已被注册过,则无须再注册,直接返回
    if (KVOClass) {
        return KVOClass;
    }
    
    //2.2 KVOClass不存在, 则创建这个类
    Class originalClass = object_getClass(self);
    KVOClass = objc_allocateClassPair(originalClass, KVOClassName.UTF8String, 0);
    
    //修改KVOClass的 class方法的实现, 学习Apple的做法, 隐瞒这个KVOClass 的class类型
    Method classMethod = class_getInstanceMethod(KVOClass, @selector(class));
    const char *type = method_getTypeEncoding(classMethod);
    
    //修改class方法的实现
    class_addMethod(KVOClass, @selector(class), (IMP)PXYKVOClass_ClassIMP, type);
    
    //注册KVOClass
    objc_registerClassPair(KVOClass);
    
    return KVOClass;
}

/**
 重写对应key的setter方法
 */
static void KVOClass_ObserveKeySetterIMP (id self, SEL cmd, id newValue) {
    //1. 获取对应key的 旧值
    //1.1 获取getter方法名,即属性名
    NSString *setterSELName = NSStringFromSelector(cmd);
    NSString *getterSELName = [self p_fetchGetterSELNameWithSetterSELName:setterSELName];
    
    //1.2 如果没有getter方法,但是下划线的成员变量有值,则无须抛错.
    //备注:此时self为派生的子类,由于我们只是重写了key的setter方法,并没有重写getter,所以才此时获取对应key的还是原始类
    //带下划线的key对应的value值,KVC是,有getter方法,则调getter方法,无getter方法,取成员变量的值,用户可能既没有getter方法,
    //也正好没设置属性值,所以此处无须抛错.
    id oldValue = [self valueForKey:getterSELName];
    
    struct objc_super KVOClassSuperClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    //这里需要做个类型强转, 否则会报too many argument的错误
    ((void (*)(void *, SEL, id))objc_msgSendSuper)(&KVOClassSuperClass, cmd, newValue);
    
    //3.获取观察者的数组 中 对应的观察者字典
    NSMutableArray *KVODictArray = objc_getAssociatedObject(self, PXYKVODictArrayKey);
    for (NSMutableDictionary *KVODict in KVODictArray) {
        if ([KVODict[PXYKVODic_Key] isEqualToString:getterSELName]) {
            //3.3 回调该观察者的block
            dispatch_async(dispatch_get_main_queue(), ^{
                PXYKVOCompleteBlock block = KVODict[PXYKVODic_Block];
                if (block) {
                    block(KVODict[PXYKVODic_Observer], getterSELName, oldValue, newValue);
                }
            });
        }
    }
}



@end

