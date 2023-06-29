//
//  Test_hook_member_function.m
//  Test
//
//  Created by wesley_chen on 2023/6/29.
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

@interface Test_hook_member_function : XCTestCase
@end

@implementation Test_hook_member_function

// Note: this way not work
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

@end
