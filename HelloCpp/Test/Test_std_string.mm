//
//  Test_std_string.m
//  Test
//
//  Created by wesley_chen on 2021/12/29.
//

#import <XCTest/XCTest.h>
#include <string>
#include <iostream>

@interface Test_std_string : XCTestCase

@end

@implementation Test_std_string

// https://stackoverflow.com/questions/8001677/how-do-i-convert-a-nsstring-into-a-stdstring
- (void)test_NSString_to_std_string {
    NSString *nsString;
    // Case 1
    nsString = @"Foo";
    std::string bar1 = std::string([nsString UTF8String]);
    std::cout << bar1 << std::endl;
    
    // Case 2
    nsString = @"中文";
    std::string bar2 = std::string([nsString UTF8String]);
    std::cout << bar2 << std::endl;
    
    // Case 3
    nsString = @"🌏";
    std::string bar3 = std::string([nsString UTF8String]);
    std::cout << bar3 << std::endl;
    
    // Abnormal Case 1: Crash
    nsString = nil;
    std::string bar4 = std::string([nsString UTF8String]); // EXC_BAD_ACCESS (code=1, address=0x0)
    std::cout << bar4 << std::endl;
}

// https://stackoverflow.com/a/7424962
- (void)test_std_string_to_NSString {
    std::string cppString;
    NSString *nsString;
    
    // Case 1
    cppString = "Foo";
    nsString = [[NSString alloc] initWithUTF8String:cppString.c_str()];
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"Foo");
    
    // Case 2
    cppString = "中文";
    nsString = [[NSString alloc] initWithUTF8String:cppString.c_str()];
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"中文");
    
    // Case 3
    cppString = "🌏";
    nsString = [[NSString alloc] initWithUTF8String:cppString.c_str()];
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"🌏");
    
    // Case 4
    using namespace std::literals;
    auto cppString2 = "中文"s;
    nsString = [[NSString alloc] initWithUTF8String:cppString2.c_str()];
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"中文");
    
    // Case 5
    std::string cppString3;
    nsString = [[NSString alloc] initWithUTF8String:cppString3.c_str()];
    NSLog(@"%@", nsString);
    XCTAssertEqualObjects(nsString, @"");
    
    // Abnormal Case 1
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wnonnull"
    XCTAssertThrows([[NSString alloc] initWithUTF8String:NULL]);
#pragma GCC diagnostic pop
    /*
    nsString = [[NSString alloc] initWithUTF8String:NULL];
    NSLog(@"%@", nsString);
     */
}

@end
