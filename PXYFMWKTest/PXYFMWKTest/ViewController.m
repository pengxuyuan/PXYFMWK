//
//  ViewController.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ImageCorner.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>
#import "NSObject+DLIntrospection.h"

#import "PXYDesHelper.h"
#import "PXYBase64Helper.h"

/*
 对称加密（共享密钥）：AES、DES
 非对称加密（公开密钥）：RSA、DH、椭圆曲线加密
 
 */

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.center = self.view.center;
    _imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    [self.view addSubview:_imageView];
    [_imageView settingCornerWithCornerRadius:100];
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *str = [PXYDesHelper stringWithDesEncryptString:@"A" withKey:@"B"];
    NSLog(@"str %@",str);
    
    // String Base64编码解码
    NSString *base641 = [PXYBase64Helper stringEncodeBase64WithString:@"AAA"];
    NSString *base642 = [PXYBase64Helper stringEncodeBase64WithString:@"ABC"];
    NSString *base643 = [PXYBase64Helper stringEncodeBase64WithString:@"111"];
    
    NSString *base6411 = [PXYBase64Helper stringDecodeBase64WithString:base641];
    NSString *base6422 = [PXYBase64Helper stringDecodeBase64WithString:base642];
    NSString *base6433 = [PXYBase64Helper stringDecodeBase64WithString:base643];
    
    //NSData Base64编码
    char *str1 = "123456789";
    NSData *data = [NSData dataWithBytes:str1 length:strlen(str1)];
    
    //data 编码
    NSData *base644 = [PXYBase64Helper dataEncodeBase64WithData:data];
    NSString *base64S = [PXYBase64Helper stringEncodeBase64WithData:data];
    
    //string 解码
    NSString *base6444 = [PXYBase64Helper stringDecodeBase64WithData:base644];
    
    //data 解码
    NSData *decodeData = [PXYBase64Helper dataDecodeBase64WithData:base644];
    NSString *decodeDataStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    
}


//#import <objc/runtime.h>
//#import <dlfcn.h>
//#import <mach-o/ldsyms.h>
//#include <limits.h>
//#include <mach-o/dyld.h>
//#include <mach-o/nlist.h>
//#include <string.h>
//
//#import "Aspects.h"
//unsigned int count;
//const char **classes;
//+ (void)load {
//    //1.获取到所有的类
//    int imageCount = (int)_dyld_image_count();
//
//    for(int iImg = 0; iImg < imageCount; iImg++) {
//
//        const char* path = _dyld_get_image_name((unsigned)iImg);
//        NSString *imagePath = [NSString stringWithUTF8String:path];
//
//        NSBundle* mainBundle = [NSBundle mainBundle];
//        NSString* bundlePath = [mainBundle bundlePath];
//
//        if ([imagePath containsString:bundlePath] && ![imagePath containsString:@".dylib"]) {
//            classes = objc_copyClassNamesForImage(path, &count);
//
//            for (int i = 0; i < count; i++) {
//                NSString *className = [NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding];
//                if (![className isEqualToString:@""] && className) {
//                    NSLog(@"============= Class %@ Start =============",className);
//                    Class class = object_getClass(NSClassFromString(className));
////                    NSLog(@"%@",className);
//
//                    if ([className isEqualToString:@"ViewController"]) {
//                        unsigned int count = 0;
//                        Class realClass = NSClassFromString(className);
//                        id obj = [realClass new];
//                        Method *methodList = class_copyMethodList([obj class], &count);
//                        for (int i = 0; i < count; i ++) {
//                            Method method = methodList[i];
//                            NSLog(@"Method: ---- %@",NSStringFromSelector(method_getName(method)));
//
//                            SEL hookSEL = method_getName(method);
//                            [obj aspect_hookSelector:hookSEL withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated) {
//                                NSLog(@"!!!!");
//                            } error:NULL];
//
//                        }
//                    }
//
//
//                    NSLog(@"============= Class %@ End ============= \n",className);
//
//                }
//            }
//        }
//    }
//
//
//    //2.获取类中的所有方法
//    //3.交换方法
//    //4.Log 调用的方法，当前类，当前函数，当前线程等信息
//}








/*
 
 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 func();
 }
 
 void pr(int (^block)(void)) {
 printf("%d\n",block());
 }
 
 void func() {
 int (^block[10])(void);
 int i;
 for (i = 0; i < 10; i ++) {
 block[i] = ^{
 return i;
 };
 }
 
 for (int j = 0; j < 10; j ++) {
 pr(block[j]);
 }
 }
 
 
 - (void)testDemo {
 NSLog(@"%s",__func__);
 }
 
 + (void)test1Demo {
 
 }
 
 
 */
@end

