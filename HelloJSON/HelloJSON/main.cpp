//
//  main.cpp
//  HelloJSON
//
//  Created by wesley_chen on 2018/6/20.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#include <iostream>
#include <map>
#include <unordered_map>

int main(int argc, const char * argv[]) {
    std::map<std::string, std::string> map;
    map["0"] = "Hello";
    map["1"] = "World";
    
    std::cout << map["0"] << ", " << map["1"] << "!\n";
    return 0;
}
