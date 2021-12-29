//
//  main.cpp
//  HelloWorld
//
//  Created by wesley_chen on 2020/7/27.
//

#include <iostream>
#include "MyService.hpp"

int main(int argc, const char * argv[]) {
    std::cout << "Hello, World!\n";
    company::SDK::MyService service1;
    service1.Request("HelloC++");
    
    std::string string1 = "Test";
    //company::SDK::MyService *service2 = new company::SDK::MyService();
    
    
    //company::SDK::MyService service = company::SDK::MyServicePtr;
    
    return 0;
}
