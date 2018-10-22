//
//  main.m
//  debug_block
//
//  Created by 八点钟学院 on 2017/11/1.
//

#import <Foundation/Foundation.h>
//#import <AppKit/AppKit.h>
#import <Block.h>

typedef void(^Block)(void);

//block源代码：https://opensource.apple.com/source/libclosure/libclosure-65/
//工程的搭建参考：http://blog.csdn.net/wotors/article/details/52489464
//main.m 转成C++的代码命令（xcode 9.4下）：xcrun -sdk macosx10.13 clang -S -rewrite-objc -fobjc-arc main.m

///分析源代码的目的：
//block本身是在栈，当在arc下，赋值给strong或copy修饰的block变量，block会自动从栈拷贝到堆区，这个流程是怎么样的？
//1、__block修饰的外部变量
//2、非__block修饰的外部变量
//这个过程会明白到block结构里的一些变量到底起什么作用

//void pr(int (^block)(void)) {
//    printf("%d\n",block());
//}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        __strong NSObject *myObject = [NSObject new];
        __weak __typeof(myObject)weakObject = myObject;
        Block block = ^{
//            __weak __typeof(myObject)weakMyObject1 = myObject;
            __strong __typeof(myObject)strongMyObject = weakObject;
//            __strong __typeof(myObject)strongMyObject1 = myObject;
            NSLog(@"QQQQQ %@",weakObject);
        };
        block();
    }

    return 0;
}






//-fno-objc-arc
