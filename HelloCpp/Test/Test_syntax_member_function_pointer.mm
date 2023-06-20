//
//  Test_syntax_member_function_pointer.m
//  Test
//
//  Created by wesley_chen on 2023/6/20.
//

#import <XCTest/XCTest.h>

#include <string>
#include <vector>
#include <iostream>
#include <cstring>
#include <dlfcn.h>

class TestClass {
public:
    void sayHello() {
        std::cout << "Hello, world!" << std::endl;
    }
};

void (*originalSayHello)(TestClass*); // 定义一个函数指针，用来保存原始的sayHello函数

void hookSayHello(TestClass* obj) {
    std::cout << "Hooked sayHello function!" << std::endl;
    originalSayHello(obj); // 调用原始的sayHello函数
}

// 声明一个指向成员函数的指针类型
typedef void (TestClass::*SayHelloPtr)();

@interface Test_syntax_member_function_pointer : XCTestCase

@end

@implementation Test_syntax_member_function_pointer

- (void)test {
    TestClass test;
//    SayHelloPtr p = &TestClass::sayHello; // 获取成员函数的地址
//    (test.*p)(); // 调用成员函数
//
//    // C++ 11
//    auto f = std::mem_fn(&TestClass::sayHello);
//    f(test); // 调用成员函数
    
//    originalSayHello = reinterpret_cast<void (*)(TestClass*)>(dlsym(RTLD_DEFAULT, "__ZN9TestClass8sayHelloEv")); // 获取原始的sayHello函数地址
    test.sayHello(); // 调用原始的sayHello函数
//
//    originalSayHello = reinterpret_cast<void (*)(TestClass*)>(dlsym(RTLD_DEFAULT, "__ZN9TestClass8sayHelloEv")); // 重新获取原始的sayHello函数地址
//    reinterpret_cast<void (*)(TestClass*)>(&hookSayHello)(&test); // 使用hookSayHello函数来hook成员函数
//    test.sayHello(); // 调用被hook的sayHello函数
}


@end
