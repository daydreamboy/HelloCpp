//
//  Test_breakpoint_for_cpp.m
//  Test
//
//  Created by wesley_chen on 2023/6/15.
//

#import <XCTest/XCTest.h>

#include <string>
#include <iostream>
#include <typeinfo>
#include <cxxabi.h>

#import <StaticFramework/SomeOCManager.h>

class A {
public:
    int getA(int a) {
        return 5;
    }
    int getA(int a, int b) {
        return 6;
    }
};

class B {
public:
    int getString(std::string a) {
        std::cout << a << std::endl;
        return 5;
    }
    int getString(std::string a, std::string b) {
        return 6;
    }
};

namespace My {
namespace Namespace {

class C {
public:
    int getInt(int a);
};

}
}

int My::Namespace::C::getInt(int a) {
    std::cout << a << std::endl;
    return 5;
}

namespace My {
namespace Namespace {

class D {
public:
    int getInt(int a);
};

}
}

namespace My {
namespace Namespace {

int D::getInt(int a) {
    std::cout << a << std::endl;
    return 6;
}

}
}

@interface Test_breakpoint_for_cpp : XCTestCase
@end

@implementation Test_breakpoint_for_cpp

- (void)test_breakpoint_check_primitive_type {
    int output;
    A a = A();
    output = a.getA(1, 2); // breakpoint: A::getA(int, int)
    
    output = a.getA(1); // breakpoint: A::getA(int)
}

- (void)test_breakpoint_check_template_type {
    int output;
    B b = B();
    
    output = b.getString("1", "2");
    
    // Note: set breakpoint B::getString(std::string) not work
    // should set breakpoint B::getString(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >)
    output = b.getString("1");
}

- (void)test_breakpoint_check_namespace {
    int output;
    // Case 1
    My::Namespace::C c = My::Namespace::C();
    output = c.getInt(1); // set breakpoint: My::Namespace::C::getInt
    
    // Case 2
    My::Namespace::D d = My::Namespace::D();
    output = d.getInt(2); // set breakpoint: My::Namespace::D::getInt(int)
}

- (void)test_breakpoint_in_framework {
    [[SomeOCManager sharedInstance] startWithConfig:@{}];
}

@end
