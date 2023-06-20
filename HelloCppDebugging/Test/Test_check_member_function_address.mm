//
//  Test_check_member_function_address.m
//  Test
//
//  Created by wesley_chen on 2023/6/20.
//

#import <XCTest/XCTest.h>

#include <iostream>

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
