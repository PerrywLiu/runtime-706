//
//  main.m
//  debug-objc
//
//  Created by suchavision on 1/24/17.
//
//


#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#import <dlfcn.h>
#import <objc/runtime.h>
#include <mach-o/loader.h>
#include <mach-o/getsect.h>
#import "TestObject/PM_TestObject.h"

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-root-class"
//#pragma clang diagnostic ignored "-Wdeprecated-objc-isa-usage"
//@interface Answer
//{
//    Class isa;
//}
//
//@property (nonatomic, assign) int value;
//
//+ (id)instantiate;
//- (void)die;
//
//+ (int)answer;
//@end

//@implementation Answer
//
//+ (id)instantiate
//{
//    Answer *result = (__bridge Answer *)(malloc(class_getInstanceSize(self)));
//    result->isa = self;
//    return result;
//}
//
//- (void)die
//{
//    free((__bridge void *)(self));
//}
//
//+ (int)answer
//{
//    return 88;
//}
//
//@end
//#ifndef __LP64__
//#define mach_header mach_header
//#else
//#define mach_header mach_header_64
//#endif

//const struct mach_header *machHeader = NULL;
//static NSString *configuraton = @"";
////设置 “__DATA,__customSection”的数据为Perry
//char *kString __attribute__((section("__DATA,__customeSection"))) = (char*)"Perry";
//
//__attribute__((constructor)) void myEntry()
//{
////    NSLog(@"constructor");
//}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
//
//        NSLog(@"my app runtime begin");
        
       
        
//        printf("TARGET_OS_MAC:%d\n",TARGET_OS_MAC);
//        printf("TARGET_OS_WIN32:%d\n",TARGET_OS_WIN32);
        
//        printf("__CNUC__:%d\n",__GNUC__);
//        printf("__APPLE_CC__%d\n",__APPLE_CC__);
//
//        printf("__OBJC2__:%d\n",__OBJC2__);
        
        
        //测试segment section
        //设置 machHeader信息
//        if (machHeader == NULL) {
//            Dl_info info;
//            dladdr((__bridge const void*)(configuraton), &info);
//            machHeader = (struct mach_header_64*)info.dli_fbase;
//        }
//
//        unsigned long byteCount = 0;
//        uintptr_t *data = (uintptr_t*)getsectiondata(machHeader, "__DATA", "__customeSection", &byteCount);
//        NSUInteger counter = byteCount/sizeof(void*);
//        for (NSUInteger idx = 0; idx < counter; ++idx) {
//            char *string = (char *)data[idx];
//            NSString *str = [NSString stringWithUTF8String:string];
//            NSLog(@"str:%@",str);
//        }
        
        
//        printf("The answer is:%d\n",[Answer answer]);
//
//        Answer *answer = [Answer instantiate];
//        answer.value = 60;
//        printf("the answer is :%d\n",answer.value);
//        [answer die];
        
        
        //测试AutoReleasePool
//         NSObject *obj = [[NSObject alloc]init];
     
//        NSArray *array = [NSArray arrayWithObjects:@"1",@"2", nil];
        
//        __weak typeof(obj) weakObj = obj;
        
        NSString *s = @"hello";
        [s stringByAppendingString:@"world"];
        
        [s class];
        object_getClass(s);
//        object_setClass(<#id  _Nullable obj#>, <#Class  _Nonnull __unsafe_unretained cls#>)
        
        
        //test isa
        PM_TestObject *testObj = [[PM_TestObject alloc]init];
        NSLog(@"testObj---%p",[testObj class]);
        NSLog(@"PM_TextObj---%p",[PM_TestObject class]);
        NSLog(@"NSObject----%p",[NSObject class]);
        
        [testObj hello];
        
        NSLog(@"asd");
    }
    return 0;
}
