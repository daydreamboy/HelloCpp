//
//  Test_keyword_extern.m
//  Test
//
//  Created by wesley_chen on 2023/12/17.
//

#import <XCTest/XCTest.h>

void cppGlobalFunc(void)
{
}

extern "C" {
    void cppGlobalFuncUsingExtern(void);
}

void cppGlobalFuncUsingExtern(void)
{
}

@interface Test_keyword_extern : XCTestCase
@end

@implementation Test_keyword_extern

- (void)test_use_extern {
    /*
    $ nm -m Test | grep "cppGlobal"
    0000000000019580 (__TEXT,__text) external __Z13cppGlobalFuncv
    0000000000019590 (__TEXT,__text) external _cppGlobalFuncUsingExtern
     */
}

@end
