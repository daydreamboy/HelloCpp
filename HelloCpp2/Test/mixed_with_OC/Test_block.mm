//
//  Test_block.m
//  Test
//
//  Created by wesley_chen on 2023/6/1.
//

#import <XCTest/XCTest.h>

#include <iostream>

//class Test_block_DummyClass {
//public:
//    int memberData;
//    void func1(void);
//    void func2(void);
//};
//
//void Test_block_DummyClass::func1()
//{
//    std::cout << "func1() called" << std::endl;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        func2();
//    });
//}
//
//void Test_block_DummyClass::func2()
//{
//    std::cout << "func2() called" << std::endl;
//    memberData = 1;
//    std::cout << "passed the check" << std::endl;
//}

@interface Test_block : XCTestCase
@end

@implementation Test_block

- (void)test_block_capture_this_pointer {
//    XCTestExpectation_BEGIN
    
//    Test_block_DummyClass *ptr = new Test_block_DummyClass();
//    ptr->func1();
//    delete ptr;
    
    [NSThread sleepForTimeInterval:1];
//    XCTestExpectation_END(3)
}

@end
