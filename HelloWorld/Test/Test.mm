//
//  Test.m
//  Test
//
//  Created by wesley_chen on 2021/12/29.
//

#import <XCTest/XCTest.h>
#import "WCCPPMacroTool.h"
#include <string>
#include <iostream>

@interface Test : XCTestCase

@end

@implementation Test

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

@end
