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

void traverse_object(json jsonObject, int indent, bool isLastElement, bool hasParentArray);

@implementation TraverseJSONObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    auto j = R"(
    {
        "header": {
            "title": "标题",
            "summary": "摘要"
        },
        "template": {
            "id": 20014,
            "data": {
                "bgl": "",
                "layout": "fix",
                "body": {}
            }
        },
        "data": [
             "data1",
             100,
             true,
             3.14
         ]
    }
    )"_json;
    
    json jsonObject = json::parse(self.jsonString);
    if (jsonObject.is_structured()) {
        traverse_object(jsonObject, 0, true, false);
    }
    else {
        std::cout << "jsonObject is not an dictionary or array" << std::endl;
    }
}

void traverse_object(json jsonObject, int indent, bool isLastElement, bool hasParentArray)
{
    if (jsonObject.is_object()) {
        if (hasParentArray) {
            std::cout << std::string(indent, ' ') << "{\n";
        }
        else {
            std::cout << "{\n";
        }
        for (json::iterator it = jsonObject.begin(); it != jsonObject.end();) {
            // +indent: as key
            std::cout << std::string(indent + 2, ' ') << "\"" << it.key() << "\"" << " : ";
            
            json value = it.value();
            
            // @see https://stackoverflow.com/questions/33657743/detect-if-iterator-is-last-element-of-stdmap
            bool isLast = false;
            if (++it == jsonObject.end()) {
                isLast = true;
            }
            
            if (value.is_structured()) {
                // +indent: as new object or array
                traverse_object(value, indent + 2, isLast, false);
            }
            else {
                std::cout << value << (isLast ? "\n" : ",\n");
            }
        }
        std::cout << std::string(indent, ' ') << (isLastElement ? "}\n" : "},\n");
    }
    else if (jsonObject.is_array()) {
        if (hasParentArray) {
            std::cout << std::string(indent, ' ') << "[\n";
        }
        else {
            std::cout << "[\n";
        }
        for (json::iterator it = jsonObject.begin(); it != jsonObject.end(); ++it) {
            
            bool isLast = false;
            if (it + 1 == jsonObject.end()) {
                isLast = true;
            }
            
            if ((*it).is_structured()) {
                // +indent: as new object or array
                traverse_object(*it, indent + 2, isLast, true);
            }
            else {
                std::cout << std::string(indent + 2, ' ') << *it << (isLast ? "\n" : ",\n");
            }
        }
        std::cout << std::string(indent, ' ') << (isLastElement ? "]\n" : "],\n");
    }
}

@end


