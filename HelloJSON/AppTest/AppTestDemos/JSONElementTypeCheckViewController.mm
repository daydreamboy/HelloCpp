//
//  JSONElementTypeCheckViewController.m
//  AppTest
//
//  Created by wesley_chen on 2018/6/22.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "JSONElementTypeCheckViewController.h"
#include "json.hpp"
#include <iostream>

using json = nlohmann::json;

@implementation JSONElementTypeCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // is_number()
    // is_number_float();
    // is_number_integer()
    // is_number_unsigned()
    // is_number_float()
    // is_object()
    // is_array()
    // is_string()
    // is_boolean()
    // is_discarded() // for callback function
    
    // is_structured() == is_array() or is_object()
    // is_primitive() == is_null() or is_string() or is_boolean() or is_number()
    
    [self test_is_null];
    [self test_is_number];
    [self test_is_array];
    [self test_is_object];
}

#pragma mark - Test Methods

- (void)test_is_null {
    auto j = R"(null)"_json;
    std::cout << (j.is_null() ? "is" : "is not") << " null" << "\n";
    
    j = R"(1)"_json;
    std::cout << (j.is_null() ? "is" : "is not") << " null" << "\n";
}

- (void)test_is_number {
    auto j = R"(null)"_json;
    std::cout << (j.is_number() ? "is" : "is not") << " number" << "\n";
    
    j = R"(1)"_json;
    std::cout << (j.is_number() ? "is" : "is not") << " number" << "\n";
}

- (void)test_is_array {
    auto j = R"([false, "1", 2])"_json;
    std::cout << (j.is_array() ? "is" : "is not") << " array" << "\n";
    
    for (json::iterator it = j.begin(); it != j.end(); ++it) {
        std::cout << *it << ' ';
    }
    std::cout << '\n';
    
    // range-based for
    for (auto& element : j) {
        std::cout << element << ' ';
    }
    std::cout << '\n';
}

- (void)test_is_object {
    auto j = R"({"string": "hello", "int": 10, "float": 3.14, "bool": true })"_json;
    
    // special iterator member functions for objects
    for (json::iterator it = j.begin(); it != j.end(); ++it) {
        std::cout << it.key() << " : " << it.value() << "\n";
    }
    
    // find an entry
    if (j.find("string") != j.end()) {
        // there is an entry with key "string"
        std::cout << j["string"] << "\n";
        
        j.erase("string");
    }
    
    if (j.find("string") == j.end()) {
        // there is not an entry with key "string"
        std::cout << "`string` key is not existed" << "\n";
    }
}

@end
