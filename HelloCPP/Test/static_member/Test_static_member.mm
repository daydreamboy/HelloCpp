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

@end
