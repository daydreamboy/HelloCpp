//
//  main.m
//  convert_NSString_to_string
//
//  Created by wesley_chen on 2018/6/20.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <iostream>
#include <string>

void convert_NSString_to_cppString(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        convert_NSString_to_cppString();
    }
    return 0;
}

void convert_NSString_to_cppString(void)
{
    // Case 1: NSString to std::string
    
    std::string string = "This is 中文";
    // @see https://stackoverflow.com/a/3552216
    // Warning: stringWithCString not handle chinese characters
    NSString *nsString1 = [NSString stringWithCString:string.c_str() encoding:[NSString defaultCStringEncoding]];
    NSLog(@"nsString1: %@", nsString1); // uncorrect output
    
    NSString *nsString2 = [NSString stringWithUTF8String:string.c_str()];
    NSLog(@"nsString2: %@", nsString2);
    
    // Case 2: std::string to NSString
    
    std::string cppString1 = [nsString1 cStringUsingEncoding:[NSString defaultCStringEncoding]];
    std::cout << "string1: " << cppString1 << std::endl;
    
    std::string cppString2 = [nsString2 UTF8String];
    std::cout << "string2: " << cppString2 << std::endl;
}

