//
//  main.m
//  debug_block
//
//  Created by 八点钟学院 on 2017/11/1.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
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
        
        int i = 0;
        Block block = ^{
            NSLog(@"%d", i);
        };
        Block blk = Block_copy(block);
        Block_copy(blk);
        Block_copy(blk);
        Block_release(blk);
        
        [blk retain];
        NSLog(@"%lu", [blk retainCount]);
        [blk retain];
        NSLog(@"%lu", [blk retainCount]);
        [blk release];
        NSLog(@"%lu", [blk retainCount]);
        
        
//        int (^block[1022222])(void);
//        int i;
//        for (i = 1000; i < 10010; i ++) {
//            block[i] = ^{
//                return i;
//            };
//        }
//
//        for (int j = 1000; j < 10010; j ++) {
//            pr(block[j]);
//        }
    }

    return 0;
}


//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        
//        int a[5] = {1,2,3,4,5};
//        int *ptr = (int *)(&a + 1);
//        printf("%d", *(ptr-1));
//        
//        __block NSButton *btn = [[NSButton alloc] init];
//        
//        void (^block)(void) = Block_copy( ^{
//            
//            NSLog(@"这是自己的block %@", btn);
//            
//        });
//        
//        block();
//        
//    }
//    return 0;
//}
//
//






//-fno-objc-arc
