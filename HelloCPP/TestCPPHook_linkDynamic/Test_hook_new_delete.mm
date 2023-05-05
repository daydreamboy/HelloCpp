//
//  TestCPPHook_linkDynamic.m
//  TestCPPHook_linkDynamic
//
//  Created by wesley_chen on 2023/5/5.
//

#import <XCTest/XCTest.h>

#include <iostream>

class MyClass {
public:
    MyClass() {
        std::cout << "Constructing MyClass" << std::endl;
    }
    
    ~MyClass() {
        std::cout << "Destructing MyClass" << std::endl;
    }
};

@interface TestCPPHook : XCTestCase
@end

@implementation TestCPPHook

- (void)test {
    std::cout << "Allocating MyClass" << std::endl;
    MyClass* ptr = new MyClass();
    std::cout << "Deleting MyClass" << std::endl;
    delete ptr;
}

@end
