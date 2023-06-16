//
//  Test_WCCPPMacroTool.m
//  Test
//
//  Created by wesley_chen on 2021/12/29.
//

#import "WCCPPMacroTool.h"

#import <XCTest/XCTest.h>

#include <string>
#include <vector>
#include <map>

#include <iostream>
#include <typeinfo>
#include <cxxabi.h>

@interface Test_WCCPPMacroTool : XCTestCase

@end

@implementation Test_WCCPPMacroTool

- (void)test_CPPStringFromNSString {
    NSString *nsString;
    std::string cppString;
    
    // Case 1
    nsString = @"Foo";
    cppString = CPPStringFromNSString(nsString);
    std::cout << cppString << std::endl;
    
    // Case 2
    nsString = @"中文";
    cppString = CPPStringFromNSString(nsString);
    std::cout << cppString << std::endl;
    
    // Case 3
    nsString = @"🌏";
    cppString = CPPStringFromNSString(nsString);
    std::cout << cppString << std::endl;
    
    // Case 4
    nsString = nil;
    cppString = CPPStringFromNSString(nsString);
    std::cout << cppString << std::endl;
}

- (void)test_NSStringFromCPPString {
    std::string cppString;
    NSString *nsString;
    
    // Case 1
    cppString = "Foo";
    nsString = NSStringFromCPPString(cppString);
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"Foo");
    
    // Case 2
    cppString = std::string("中文");
    nsString = NSStringFromCPPString(cppString);
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"中文");

    // Case 3
    cppString = "🌏";
    nsString = NSStringFromCPPString(cppString);
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"🌏");

    // Case 4
    using namespace std::literals;
    auto cppString2 = "中文"s;
    std::cout << cppString2 << std::endl;
    
    nsString = NSStringFromCPPString(cppString2);
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"中文");

    // Case 5
    std::string cppString3;
    nsString = NSStringFromCPPString(cppString3);
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"");
}

- (void)test_WCDumpType {
    // Case 1: C type
    WCDumpType(int)
    WCDumpType(int64_t)
    
    WCDumpType(double)
    WCDumpType(float)
    
    WCDumpType(char)
    WCDumpType(bool)
    
    // Case 2: C++ type
    WCDumpType(std::string)
    WCDumpType(std::vector<int>)
    WCDumpType(std::vector<std::string>)
    WCDumpType(std::map<int, int>)
    WCDumpType(std::map<std::string, std::string>)
}

- (void)test_SHOW_VALUE_CATEGORY {
    std::string str1 = "Salut";
    std::string str2 = std::move(str1);
    std::string str3 = std::move("hello");
    
    SHOW_VALUE_CATEGORY("hello");
    SHOW_VALUE_CATEGORY(std::move("hello"));
    SHOW_VALUE_CATEGORY(str3);
    SHOW_VALUE_CATEGORY(str3 = std::move("hello"));
    SHOW_VALUE_CATEGORY(1);
    SHOW_VALUE_CATEGORY(1 + 2);
}

@end
