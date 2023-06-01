//
//  Test_static_member_function.m
//  Test
//
//  Created by wesley_chen on 2023/5/14.
//

#import <XCTest/XCTest.h>

#include <iostream>
#include "DerivedClass1.hpp"
#include "DefineStaticMember.hpp"

using namespace std;

class X { public: static int n; }; // declaration (uses 'static')
int X::n = 1;              // definition (does not use 'static')

@interface Test_static_member_function : XCTestCase
@end

@implementation Test_static_member_function

- (void)test_X {
    std::cout << X::n << std::endl;
}

- (void)test_X2 {
    // Case1: static member owned by class
    std::cout << X2::n << std::endl;
    X2::f();
    
    // Case2: static member shared by all objects
    X2 o1;
    std::cout << o1.n << std::endl;
}

- (void)test_DefineStaticMember {
    S o1;
    std::cout << &o1.s << std::endl;
    std::cout << &o1.x << std::endl;
    std::cout << o1.a << std::endl;
}

- (void)test_static_member_inheritance {
    // Note: Use `==` for two std::string, @see https://www.tutorialkart.com/cpp/cpp-string-equals/#gsc.tab=0
    
    // Case1: foo() only in base class, so it always call base class's function
    XCTAssertTrue(DerivedClass1::foo() == string("bar"));
    
    // Case2: bar() both defined in derived and base class, but they are belong to each class
    XCTAssertTrue(BaseClass1::bar() == string("bar"));
    XCTAssertTrue(DerivedClass1::bar() == string("baz"));
}

- (void)test_none_inline_implement_static_member_function {
    XCTAssertTrue(DerivedClass1::description() == string("This is DerivedClass1"));
}

@end
