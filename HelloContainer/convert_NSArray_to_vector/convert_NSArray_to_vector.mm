//
//  main.m
//  convert_NSArray_to_vector
//
//  Created by wesley_chen on 2018/6/20.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <vector>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // @see https://stackoverflow.com/a/44667412
        NSArray *arr = @[@"1", @"2"];
        
        std::vector<NSString *> v;
        
        for (NSString *string in arr) {
            v.push_back(string);
        }
        
        // Note: use & as reference to not generate copies
        for (const auto& item : v) {
            NSLog(@"%@", item);
        }
    }
    return 0;
}
