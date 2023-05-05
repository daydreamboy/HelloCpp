//
//  Test_std_shared_ptr.m
//  Test
//
//  Created by wesley_chen on 2023/5/5.
//

#import <XCTest/XCTest.h>

#include <iostream>
#include <memory>
#include <type_traits>

struct C
{
    // constructors needed (until C++20)
    C(int i) : i(i) {}
    C(int i, float f) : i(i), f(f) {}
    int i;
    float f{};
};

@interface Test_std_shared_ptr : XCTestCase

@end

@implementation Test_std_shared_ptr

// example from https://cplusplus.com/reference/memory/make_shared/
- (void)test_create_shared_ptr {
    // Style1: Use make_shared to create
    std::shared_ptr<int> foo = std::make_shared<int>(10);
    // Style2: Use constructor to create
    std::shared_ptr<int> foo2(new int(10));
    
    std::cout << *foo << std::endl;
    std::cout << *foo2 << std::endl;
}

- (void)test_make_shared_return_auto_type {
    auto bar = std::make_shared<int>(20);
    std::cout << *bar << std::endl;
}

- (void)test_make_shared_with_std_pair {
    auto baz = std::make_shared<std::pair<int,int>>(30, 40);
    std::cout << "*baz: " << baz->first << ' ' << baz->second << std::endl;
}

- (void)test_make_shared_with_custom_struct {
    // Case 1
    auto sp1 = std::make_shared<C>(1); // overload (1)
    static_assert(std::is_same_v<decltype(sp1), std::shared_ptr<C>>);
    std::cout << "sp1->{ i:" << sp1->i << ", f:" << sp1->f << " }\n";
    
    // Case 2
    std::shared_ptr<C> sp2 = std::make_shared<C>(2, 3.0f); // overload (1)
    static_assert(std::is_same_v<decltype(sp2), std::shared_ptr<C>>);
    std::cout << "sp2->{ i:" << sp2->i << ", f:" << sp2->f << " }\n";
}

@end
