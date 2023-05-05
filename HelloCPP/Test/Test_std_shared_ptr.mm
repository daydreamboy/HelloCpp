//
//  Test_std_shared_ptr.m
//  Test
//
//  Created by wesley_chen on 2023/5/5.
//

#import <XCTest/XCTest.h>

#include <iostream>
#include <memory>

@interface Test_std_shared_ptr : XCTestCase

@end

@implementation Test_std_shared_ptr

- (void)test_create_shared_ptr {
    std::shared_ptr<int> foo = std::make_shared<int>(10);
    std::shared_ptr<int> foo2(new int(10));
    
    std::cout << *foo << std::endl;
    std::cout << *foo2 << std::endl;
}

@end
