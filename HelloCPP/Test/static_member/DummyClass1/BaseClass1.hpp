//
//  BaseClass1.hpp
//  Test
//
//  Created by wesley_chen on 2023/5/14.
//

#ifndef BaseClass1_hpp
#define BaseClass1_hpp

#include <memory>
#include <string>

class BaseClass1 {
public:
    static std::string bar() {
        return "bar";
    }
    static std::string foo() {
        return bar();
    }
    static std::string description();
};

#endif /* BaseClass1_hpp */
