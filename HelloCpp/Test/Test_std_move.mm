//
//  Test_std_move.m
//  Test
//
//  Created by wesley_chen on 2021/12/30.
//

#import <XCTest/XCTest.h>

#include <iomanip>
#include <iostream>
#include <utility>
#include <vector>
#include <string>

#import "WCCPPMacroTool.h"

@interface Test_std_move : XCTestCase

@end

@implementation Test_std_move

- (void)test_std_move_simple_example {
    // Case 1
    std::string str1 = "Salut";
    std::string str2 = std::move(str1);
    std::string str3 = std::move("hello");
    std::string str4 = "Hello, ";
    std::string str5 = "World!";
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpessimizing-move"
    std::string str6 = std::move(str4 + str5);
#pragma GCC diagnostic pop
    
    std::cout << "str1 is " << std::quoted(str1) << std::endl;
    std::cout << "str2 is " << std::quoted(str2) << std::endl;
    std::cout << "str3 is " << std::quoted(str3) << std::endl;
    std::cout << "str4 is " << std::quoted(str4) << std::endl;
    std::cout << "str5 is " << std::quoted(str5) << std::endl;
    std::cout << "str6 is " << std::quoted(str6) << std::endl;
    
    // Case 2
    SHOW_VALUE_CATEGORY("hello");
    SHOW_VALUE_CATEGORY(std::move("hello"));
    SHOW_VALUE_CATEGORY(str3);
    SHOW_VALUE_CATEGORY(str3 = std::move("hello"));
}

- (void)test_std_move_with_vector {
    // Case 2
    std::string str = "Salut";
    std::vector<std::string> v;
 
    // uses the push_back(const T&) overload, which means
    // we'll incur the cost of copying str
    v.push_back(str);
    std::cout << "After copy, str is " << std::quoted(str) << '\n';
 
    // uses the rvalue reference push_back(T&&) overload,
    // which means no strings will be copied; instead, the contents
    // of str will be moved into the vector.  This is less
    // expensive, but also means str might now be empty.
    v.push_back(std::move(str));
    std::cout << "After move, str is " << std::quoted(str) << '\n';
 
    std::cout << "The contents of the vector are { " << std::quoted(v[0])
                                             << ", " << std::quoted(v[1]) << " }\n";
}

@end
