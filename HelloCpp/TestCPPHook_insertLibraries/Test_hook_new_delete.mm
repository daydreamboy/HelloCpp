//
//  TestCPPHook_insertLibraries.m
//  TestCPPHook_insertLibraries
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

@interface TestCPPHook_insertLibraries : XCTestCase
@end

@implementation TestCPPHook_insertLibraries

- (void)test {
    std::cout << "Allocating MyClass" << std::endl;
    MyClass* ptr = new MyClass();
    std::cout << "Deleting MyClass" << std::endl;
    delete ptr;
}

@end
