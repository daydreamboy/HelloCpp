//
//  main.cpp
//  nlohmann_json
//
//  Created by wesley_chen on 2018/6/20.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#include <iostream>
#include "nlohmann/json.hpp"

using json = nlohmann::json;

void test_nlohmann_json(void);

int main(int argc, const char * argv[]) {
    test_nlohmann_json();
    
    return 0;
}

void test_nlohmann_json(void)
{
    json jsonObject = {
        {"pi", 3.141},
        {"happy", true},
        {"name", "Niels"},
        {"nothing", nullptr},
        {"answer", {
            {"everything", 42}
        }},
        {"list", {1, 0, 2}},
        {"object", {
            {"currency", "USD"},
            {"value", 42.99}
        }}
    };
    
    std::string jsonString = jsonObject.dump();
    std::cout << jsonString << std::endl;
    std::cout << jsonObject.dump(4) << std::endl;
}
