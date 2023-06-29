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

typedef void (TestClass::*SayHelloPtr)(void);

@interface Test_check_member_function_address : XCTestCase
@end

@implementation Test_check_member_function_address

- (void)test_check_member_function_address {
    // Case 1: print member function address
    SayHelloPtr p = &TestClass::sayHello;
    
    // Note: use void *& reference force convert to disable warning
    // https://stackoverflow.com/a/11112061
    printf("sayHello func address: %p\n", (void *&)p);
}

@end
