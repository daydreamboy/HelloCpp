//
//  Test_syntax_reference.m
//  Test
//
//  Created by wesley_chen on 2023/6/16.
//

#import <XCTest/XCTest.h>

#import "WCCPPMacroTool.h"
#import "WCCPPTool.h"

#include <iostream>
#include <string>

void print(std::string& str) {
    std::cout << "lvalue print" << std::endl;
}

void print(std::string&& str) {
    std::cout << "rvalue print" << std::endl;
}

@interface Test_syntax_reference : XCTestCase
@end

@implementation Test_syntax_reference

- (void)test_syntax_not_support_reference {
    /*
     int& a[3]; // error
     int&* p;   // error
     int& &r;   // error
     */
}

- (void)test_syntax_reference_collapsing {
    typedef int&  lref;
    typedef int&& rref;
    int n;
    
    lref&  r1 = n; // type of r1 is int&
    lref&& r2 = n; // type of r2 is int&
    rref&  r3 = n; // type of r3 is int&
    rref&& r4 = 1; // type of r4 is int&&
    
    WCDumpObject(r1);
    WCDumpObject(r2);
    WCDumpObject(r3);
    WCDumpObject(r4);
}

#pragma mark - lvalue reference

- (void)test_syntax_lvalue_reference_variable {
    std::string s = "Ex";
    std::string& r1 = s;
    const std::string& r2 = s;
 
    r1 += "ample";           // modifies s
    //r2 += "!";               // error: cannot modify through reference to const
    std::cout << r2 << '\n'; // prints s, which now holds "Example"
}

void double_string(std::string& s)
{
    s += s; // 's' is the same object as main()'s 'str'
}

- (void)test_syntax_lvalue_reference_parameter_modify_orignal_variable {
    std::string str = "Test";
    double_string(str);
    std::cout << str << '\n';
}

char& char_number(std::string& s, std::size_t n)
{
    return s.at(n); // string::at() returns a reference to char
}

- (void)test_syntax_function_return_type_lvalue_reference {
    std::string str = "Test";
    char_number(str, 1) = 'a'; // the function call is lvalue, can be assigned to
    std::cout << str << '\n';
}

#pragma mark - rvalue reference

- (void)test_syntax_rvalue_reference {
    std::string s1 = "Hello, ";
    std::string s2 = "World!";
    std::string s3 = s1 + s2;

    print(s3);              // lvalue reference
    print(s1 + s2);         // rvalue reference
    print(std::move(s3));   // rvalue reference
}

@end
