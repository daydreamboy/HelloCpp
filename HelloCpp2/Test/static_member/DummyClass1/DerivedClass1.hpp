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

// example from https://stackoverflow.com/questions/34222703/how-to-override-static-method-of-template-class-in-derived-class
class DerivedClass1: public BaseClass1 {
public:
    static std::string bar() {
        return "baz";
    }
    // Note: should re-declare again for static member function
    static std::string description();
};

#endif /* DerivedClass1_hpp */
