//
//  Test_abstract_class.m
//  Test
//
//  Created by wesley_chen on 2023/5/15.
//

#import <XCTest/XCTest.h>
 
#include "AbstractClass1.hpp"
#include "AbstractClass2.hpp"
#include "ConcreteClass1.hpp"
 
@interface Test_abstract_class : XCTestCase
@end

@implementation Test_abstract_class

- (void)test_use_abstract_class_type {
    //AbstractClass1 a;   // Error: abstract class
    ConcreteClass1 b;      // OK
    AbstractClass1& a = b; // OK to reference abstract base
    a.f();           // virtual dispatch to Concrete::f()
    //AbstractClass2 a2; // Error: abstract class (final overrider of g() is pure)
}

- (void)test_none_inline_implement_pure_virtual_function {
    ConcreteClass1 b;
    b.h(); // will print `h() called`
}

@end
