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

// Define a type for pointer to member function
typedef void (TestClass::*SayHelloPtr)();

@interface Test_syntax_member_function_pointer : XCTestCase

@end

@implementation Test_syntax_member_function_pointer

- (void)test {
    TestClass test;
    
    // Case 1: call as object's member function
    SayHelloPtr p = &TestClass::sayHello; // get member function address
    // https://stackoverflow.com/questions/12189057/how-to-call-through-a-member-function-pointer
    (test.*p)(); // call member function
    
    // Note: cast to void * reference
    // @see https://stackoverflow.com/a/11112061
    NSLog(@"%p", (void* &)p);
    
    void (TestClass::*p2)(void) = &TestClass::sayHello;
    (test.*p2)();

    // Case 2: C++ 11, use std::mem_fn to wrapper the member function address
    auto f = std::mem_fn(&TestClass::sayHello);
    f(test); // call member function
    
    // Note: not work
    /*
    originalSayHello = reinterpret_cast<void (*)(TestClass*)>(dlsym(RTLD_DEFAULT, "__ZN9TestClass8sayHelloEv")); // 获取原始的sayHello函数地址
    test.sayHello(); // 调用原始的sayHello函数

    originalSayHello = reinterpret_cast<void (*)(TestClass*)>(dlsym(RTLD_DEFAULT, "__ZN9TestClass8sayHelloEv")); // 重新获取原始的sayHello函数地址
    reinterpret_cast<void (*)(TestClass*)>(&hookSayHello)(&test); // 使用hookSayHello函数来hook成员函数
    test.sayHello(); // 调用被hook的sayHello函数
     */
}


@end
