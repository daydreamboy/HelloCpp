//
//  main.cpp
//  map
//
//  Created by wesley_chen on 2018/6/20.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#include <iostream>
#include <map>
#include <string>

int main(int argc, const char * argv[]) {
    // @see https://stackoverflow.com/questions/11270738/does-c-have-a-dictionary-similar-to-objective-cs-nsdictionary
    std::map<std::string, std::string> map;
    map["0"] = "Hello";
    map["1"] = "World";
    
    std::cout << map["0"] << ", " << map["1"] << "!\n";
    return 0;
}

