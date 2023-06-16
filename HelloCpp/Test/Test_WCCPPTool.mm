//
//  Test_WCCPPTool.m
//  Test
//
//  Created by wesley_chen on 2023/6/15.
//

#import <XCTest/XCTest.h>

#import "WCCPPTool.h"

#include <string>

@interface Test_WCCPPTool : XCTestCase

@end

@implementation Test_WCCPPTool

- (void)test_WCDumpObject {
    // Case 1: C type value
    WCDumpObject(42);         // 42 = int
    WCDumpObject("hello");    // hello = char [6]
    WCDumpObject(3.14f);      // 3.14 = float
    WCDumpObject(3.15);      // 3.15 = double
    WCDumpObject(true);      // 1 = bool
    
    // Case 2: C++ type value
    std::string string = "abc";
    WCDumpObject(string); // std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char>>
}

@end
