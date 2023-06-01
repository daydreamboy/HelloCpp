//
//  Test_std_bind.m
//  Test
//
//  Created by wesley_chen on 2023/3/6.
//

#import <XCTest/XCTest.h>

#include <functional>
#include <iostream>
#include <cassert>

using namespace std;
using namespace std::placeholders;  // for _1, _2, _3...

@interface Test_std_bind : XCTestCase

@end

@implementation Test_std_bind

int add(int first, int second)
{
    printf("first: %d, second: %d\n", first, second);
    return first + second;
}

bool divisible(int num , int den)
{
    if(num % den == 0)
        return true;
    return false;
}

#pragma mark -

- (void)test_bind_with_placeholder_parameters {
    // Note: add_func accept two parameters
    auto add_func = std::bind(&add, _1, _2);
    int result = add_func(4, 5);
    std::cout << result << std::endl;
    assert(result == 9);
}

- (void)test_bind_with_default_parameters {
    // Note: add_func only accept only one parameter
    auto add_func = std::bind(&add, 12, _1);
    int result = add_func(5);
    std::cout << result << std::endl;
    assert(result == 17);
}

- (void)test_bind_with_reorder_placeholder_parameters {
    // Note: add_func pass (4, 5) will reoder into (5, 4) to the `add` function
    auto add_func = std::bind(&add, _2, _1);
    int result = add_func(4, 5);
    std::cout << result << std::endl;
    assert(result == 9);
}

// Note: std::bind usually works with STL algorithm
// Example from https://thispointer.com/stdbind-tutorial-and-usage-details/
- (void)test_bind_with_stl_algorithm {
    // Case 1: plain style
    int arr[10] = {1,20,13,4,5,6,10,28,19,15};
    int count = 0;
    for(int i = 0; i < sizeof(arr)/sizeof(int); i++) {
        if (divisible(arr[i], 5)) {
            count++;
        }
    }
    assert(count == 4);
    
    // Case 2: STL style
    count = (int)std::count_if(arr, arr + sizeof(arr)/sizeof(int), std::bind(&divisible, _1, 5));
    assert(count == 4);
}

@end
