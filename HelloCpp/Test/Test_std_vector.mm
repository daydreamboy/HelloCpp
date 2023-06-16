//
//  Test_std_vector.m
//  Test
//
//  Created by wesley_chen on 2021/12/30.
//

#import <XCTest/XCTest.h>
#include <string>
#include <vector>
#include <iostream>
#include <iomanip>

@interface Test_std_vector : XCTestCase

@end

@implementation Test_std_vector

- (void)test_push_back {
    // create a string vector
    std::vector<std::string> strings;
    
    // put an item
    strings.push_back("abc");
    
    // put an item
    std::string s = "def";
    strings.push_back(s);
    
    std::cout << "vector holds: ";
    for (auto&& aString : strings)
    {
        std::cout << aString << ' ';
    }
    std::cout << std::endl;
}

@end
