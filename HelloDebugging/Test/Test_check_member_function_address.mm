//
//  Test_check_member_function_address.m
//  Test
//
//  Created by wesley_chen on 2023/6/20.
//

#import <XCTest/XCTest.h>

#include <iostream>


class MyClass {
public:
    void myFunction(int x) {
        std::cout << "Original myFunction called with value: " << x << std::endl;
    }
};

void myHookedFunction(MyClass* instance, int x) {
    std::cout << "Hooked myFunction called with value: " << x << std::endl;
    // 在这里你可以加上一些你自己的代码，也可以调用原始函数
    instance->myFunction(x);
}

class TestClass {
public:
    void sayHello() {
        // Note: make a breakpoint here
        std::cout << "Hello, world!" << std::endl;
    }
};

typedef void (TestClass::*SayHelloPtr)();

@interface Test_check_member_function_address : XCTestCase

@end

@implementation Test_check_member_function_address

// https://juejin.cn/s/c%2B%2B%20hook%20member%20function
- (void)test {
    MyClass obj;
    //void (MyClass::*originalFunction)(int) = &MyClass::myFunction;
    //void (*hookedFunction)(MyClass*, int) = &myHookedFunction;
    
    // Hook myFunction
    //std::swap(*reinterpret_cast<void**>(&(obj.*originalFunction)), *reinterpret_cast<void**>(&hookedFunction));
    // 调用myFunction，这将自动调用我们的钩子函数
    obj.myFunction(42);
    // Unhook myFunction
    //std::swap(*reinterpret_cast<void**>(&obj.*originalFunction), *reinterpret_cast<void**>(&hookedFunction));
    // 再次调用myFunction，现在它将调用原始函数
    //obj.myFunction(42);
}

- (void)test_check_member_function_address {
    TestClass test;
    
    // Case 1: print member function address
    SayHelloPtr p = &TestClass::sayHello;
    
    // Note: use void *& reference force convert to disable warning
    // https://stackoverflow.com/a/11112061
    printf("sayHello address: %p\n", (void *&)p);
    test.sayHello();
    
    // Case 2: use member function address to call member function
    void (TestClass::*p2)(void) = &TestClass::sayHello;
    // https://stackoverflow.com/questions/12189057/how-to-call-through-a-member-function-pointer
    (test.*p2)();
}

@end
