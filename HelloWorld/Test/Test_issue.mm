//
//  Test_issue.m
//  Test
//
//  Created by wesley_chen on 2022/1/4.
//

#import <XCTest/XCTest.h>
#include <string>
#include <vector>

@interface Test_issue : XCTestCase

@end

@implementation Test_issue

- (void)test_push_back {
    // Case 1: block not support C++ code
    std::vector<std::string> strings;
    NSArray<NSString *> *arr = @[ @"1", @"2" ];
    
    /*
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        std::string s = std::string([obj UTF8String]);
        strings.push_back(s);
    }];
     */
    
    for (NSInteger i = 0; i < arr.count; ++i) {
        NSString *e = arr[i];
        std::string s = std::string([e UTF8String]);
        strings.push_back(s);
    }
}

@end
