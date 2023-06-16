//
//  Test_syntax_rvalue_reference.m
//  Test
//
//  Created by wesley_chen on 2023/6/16.
//

#import <XCTest/XCTest.h>

#include <iostream>
#include <string>

void print(std::string& str) {
    std::cout << "lvalue print" << std::endl;
}

void print(std::string&& str) {
    std::cout << "rvalue print" << std::endl;
}

@interface Test_syntax_rvalue_reference : XCTestCase
@end

@implementation Test_syntax_rvalue_reference

- (void)test_syntax_rvalue_reference {
    std::string s1 = "Hello, ";
    std::string s2 = "World!";
    std::string s3 = s1 + s2;

    print(s3);              // lvalue reference
    print(s1 + s2);         // rvalue reference
    print(std::move(s3));   // rvalue reference
}

@end
