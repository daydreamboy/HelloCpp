//
//  Test.m
//  Test
//
//  Created by wesley_chen on 2023/1/1.
//

#import <XCTest/XCTest.h>

#include <string>
#include <sstream>

@interface Test : XCTestCase

@end

@implementation Test

- (void)test_std_ostringstream {
    std::ostringstream stream;
    
    stream << "Hello, " << "ostring" << "stream";
    stream << std::endl;
    
    std::string string = stream.str();
    const char* s = string.c_str();
    
    // Warning: Object backing the pointer will be destroyed at the end of the full-expression
    // https://stackoverflow.com/questions/66290661/why-is-this-dangling-gsl-warning-invoked
    //const char* s = stream.str().c_str();
    printf("%s", s);
}

- (void)test_std_strlen {
    char buf[64];
    
    if (std::strlen(buf) > 0) {
        printf("%s", buf);
    }
    
    const char buf2[] = "How many characters does this string contain?\n";
    
    if (std::strlen(buf2) > 0) {
        printf("%s", buf2);
    }
}

@end