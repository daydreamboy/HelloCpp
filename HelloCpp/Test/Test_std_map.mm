//
//  Test_std_map.m
//  Test
//
//  Created by wesley_chen on 2024/3/18.
//

#import <XCTest/XCTest.h>

#import <map>

struct _xtrace_info {
    int depth;
    void *caller;
    BOOL callingBack;
};

@interface Test_std_map : XCTestCase

@end

@implementation Test_std_map

- (void)test_operator_square_bracket {
    // C++ doc:
    // operator[]: access or insert specified element (public member function)
    std::map<__unsafe_unretained Class, std::map<SEL,struct _xtrace_info>> map;
    
    Class clz = [Test_std_map class];
    SEL sel = NSSelectorFromString(@"stub1");
    
    // Case1
    struct _xtrace_info &info1 = map[clz][sel];
    info1.depth = 1;
    XCTAssertTrue(info1.depth == 1);
    
    // Case2
    sel = NSSelectorFromString(@"stub2");
    struct _xtrace_info *info2 = &map[clz][sel];
    info2->depth = 1;
    XCTAssertTrue(info2->depth == 1);
}

@end
