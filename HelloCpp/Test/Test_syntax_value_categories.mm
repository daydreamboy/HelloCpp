//
//  Test_syntax_value_categories.m
//  Test
//
//  Created by wesley_chen on 2023/6/17.
//

#import <XCTest/XCTest.h>

#include "WCCPPMacroTool.h"

@interface Test_syntax_value_categories : XCTestCase

@end

@implementation Test_syntax_value_categories

struct Foo {
    int x;
};

Foo createFoo() {
    return Foo{42};
}

- (void)test_xvalue {
    // Case 1
    SHOW_VALUE_CATEGORY(std::move("hello")); // xvalue
    
    // Case 2
    SHOW_VALUE_CATEGORY(createFoo().x); // xvalue
    
    // Case 3
    int Foo::* p = &Foo::x;
    int&& x = createFoo().*p;
    SHOW_VALUE_CATEGORY(createFoo().*p); // xvalue
    
    // Case 4
    int x2 = 42;
    int&& y = static_cast<int&&>(x2);
    SHOW_VALUE_CATEGORY(static_cast<int&&>(x));  // xvalue
    SHOW_VALUE_CATEGORY(y); // lvalue
    
    // Case 5
    __unused int x3 = (int[]){1, 2, 3}[1]; // a[n], the built-in subscript expression, where one operand is an array rvalue;
    SHOW_VALUE_CATEGORY((int[]){1, 2, 3}[1]); // xvalue
}

@end
