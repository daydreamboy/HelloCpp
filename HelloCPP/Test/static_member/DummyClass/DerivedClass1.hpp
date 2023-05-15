//
//  DerivedClass1.hpp
//  Test
//
//  Created by wesley_chen on 2023/5/14.
//

#ifndef DerivedClass1_hpp
#define DerivedClass1_hpp

#include "BaseClass1.hpp"
#include <iostream>
#include <string>

class DerivedClass1: public BaseClass1 {
public:
    static std::shared_ptr<BaseClass1> create() {
        return std::make_shared<DerivedClass1>();
    }
//    std::string description();
};

#endif /* DerivedClass1_hpp */
