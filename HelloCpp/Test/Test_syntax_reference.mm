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
    
    XCTAssertTrue(std::is_lvalue_reference_v<lref&>);
    XCTAssertTrue(std::is_lvalue_reference_v<lref&&>);
    XCTAssertTrue(std::is_lvalue_reference_v<rref&>);
    XCTAssertTrue(std::is_rvalue_reference_v<rref&&>);
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

- (void)test_syntax_rvalue_reference_for_temperary_object {
    // Case 1
    std::string s1 = "Test";
    //std::string& lref1 = "Test"; // Error: lvalue ref only apply object or function
    const std::string& lref1 = "Test";
    std::string&& rref1 = "Test"; // Ok: rvalue ref apply temp object which compiler create a temp std::string
  
    // Case 2
    //std::string& lref2 = s1 + s1; // Error: lvalue ref can't apply a temperary type
    const std::string& lref2 = s1 + s1; // okay: lvalue reference to const extends lifetime
    std::string&& rref2 = s1 + s1; // okay: lvalue reference to const extends lifetime
    rref2 += "Test"; // okay: can modify through reference to non-const
    
    std::cout << rref2 << '\n';
}

- (void)test_syntax_rvalue_reference_restrict_usage {
    std::string s1 = "Test";
    //std::string&& r1 = s1;           // error: can't bind to lvalue
}

void f(int& x)
{
    std::cout << "lvalue reference overload f(" << x << ")\n";
}
 
void f(const int& x)
{
    std::cout << "lvalue reference to const overload f(" << x << ")\n";
}
 
void f(int&& x)
{
    std::cout << "rvalue reference overload f(" << x << ")\n";
}

- (void)test_syntax_rvalue_reference_function_overload {
    int i = 1;
    const int ci = 2;
 
    f(i);  // calls f(int&)
    f(ci); // calls f(const int&)
    f(3);  // calls f(int&&)
           // would call f(const int&) if f(int&&) overload wasn't provided
    f(std::move(i)); // calls f(int&&)
 
    // rvalue reference variables are lvalues when used in expressions
    int&& x = 1;
    f(x);            // calls f(int& x)
    f(std::move(x)); // calls f(int&& x)
}

- (void)test_syntax_rvalue_reference_work_with_std_move {
    int i2 = 42;
    int&& rri = std::move(i2); // binds directly to i2
    
    std::vector<int> v{1, 2, 3, 4, 5};
    std::vector<int> v2(std::move(v)); // binds an rvalue reference to v
    assert(v.empty());
}

@end
