//
//  TestCPPHook.m
//  TestCPPHook
//
//  Created by wesley_chen on 2023/5/5.
//

#import <XCTest/XCTest.h>

#include <iostream>

namespace My {
namespace Namespace {

class Request {
public:
    Request(const std::string& requestLine);
};

}
}

My::Namespace::Request::Request(const std::string& requestLine)
{
    std::cout << "requestLine: " << requestLine << std::endl;
}


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

- (void)test_custom_class {
    std::cout << "Allocating MyClass" << std::endl;
    MyClass* ptr = new MyClass();
    std::cout << "Deleting MyClass" << std::endl;
    delete ptr;
}

- (void)test_custom_class_with_parameter {
    My::Namespace::Request *r = new My::Namespace::Request("some/request");
    delete r;
}

@end
