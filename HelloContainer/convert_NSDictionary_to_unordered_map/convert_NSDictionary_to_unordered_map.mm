//
//  main.m
//  convert_NSDictionary_to_unordered_map
//
//  Created by wesley_chen on 2018/6/20.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <iostream>
#include <unordered_map>
#include <string>

void test_convert_NSDictionary_to_unordered_map(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test_convert_NSDictionary_to_unordered_map();
    }
    return 0;
}

void test_convert_NSDictionary_to_unordered_map(void)
{
    NSDictionary *dict = @{
                           @"RED": @"#FF0000",
                           @"GREEN": @"#00FF00",
                           @"BLUE": @"#0000FF",
                           };
    
    std::unordered_map<std::string, std::string> umap;
    
    for (NSString *key in dict) {
        umap[[key UTF8String]] = [dict[key] UTF8String];
    }
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (const auto& item : umap) {
        std::string cKey = item.first;
        std::string cValue = item.second;
        
        std::cout << "Key: [" << cKey << "], Value: [" << cValue << "]" << std::endl;
        
        // @see https://stackoverflow.com/a/3552216
        NSString *key = [NSString stringWithCString:cKey.c_str() encoding:[NSString defaultCStringEncoding]];
        NSString *value = [NSString stringWithCString:cValue.c_str() encoding:[NSString defaultCStringEncoding]];
        dictM[key] = value;
    }
    
    NSLog(@"dictM: %@", dictM);
}
