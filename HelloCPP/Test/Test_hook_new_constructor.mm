//
//  Test_hook_new_constructor.m
//  Test
//
//  Created by wesley_chen on 2023/3/29.
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

@interface Test_hook_new_constructor : XCTestCase

@end

@implementation Test_hook_new_constructor

- (void)testExample {
    std::cout << "Allocating MyClass" << std::endl;
    MyClass* ptr = new MyClass();
    std::cout << "Deleting MyClass" << std::endl;
    delete ptr;
}

@end
