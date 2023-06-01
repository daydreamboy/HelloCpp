//
//  MyService.cpp
//  HelloWorld
//
//  Created by wesley_chen on 2020/7/27.
//

#include "MyService.hpp"
#include <iostream>

/*
class MyInternalService: public company::SDK::MyService {
    void Request(const std::string &name) override {
        std::cout << name << std::endl;
    }
};
 */

void company::SDK::MyService::Request(const std::string &name) {
    std::cout << name << std::endl; // p (std::string *)$rsi, @see https://stackoverflow.com/questions/40424192/make-lldb-reinterpret-address-as-pointer-to-an-object-whose-type-is-a-template-i
}
