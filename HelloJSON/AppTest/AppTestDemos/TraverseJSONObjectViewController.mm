//
//  TraverseJSONObjectViewController.m
//  AppTest
//
//  Created by wesley_chen on 2018/6/22.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "TraverseJSONObjectViewController.h"
#include "json.hpp"
#include <iostream>

using json = nlohmann::json;

void traverse_object(json jsonObject, int indent)
{
    if (jsonObject.is_object()) {
        
        std::string space = std::string(indent, ' ');
        
        for (json::iterator it = jsonObject.begin(); it != jsonObject.end(); ++it) {
            std::cout << it.key() << " : " << "\n";
            
            
        }
    }
}

void loop_array(void);

@implementation TraverseJSONObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    json jsonObject = json::parse(self.jsonString);
//    if (jsonObject.is_object()) {
//        for (json::iterator it = jsonObject.begin(); it != jsonObject.end(); ++it) {
//            std::cout << it.key() << " : " << it.value() << "\n";
//        }
//    }
//    else {
//        std::cout << "jsonObject is not an dictionary" << std::endl;
//    }
    
    loop_array();
}

void loop_array(void)
{
    auto array = R"(
    [ "1", 2, true, null ]
    )"_json;
    
    std::cout << array.dump() << std::endl;
    
    // iterate the array
    for (json::iterator it = array.begin(); it != array.end(); ++it) {
        
        if ((*it).is_null()) {
            std::cout << "null: ";
        }
        
        std::cout << *it << '\n';
    }
}

@end
