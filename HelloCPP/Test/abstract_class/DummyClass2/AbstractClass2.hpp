//
//  AbstractClass2.hpp
//  Test
//
//  Created by wesley_chen on 2023/5/15.
//

#ifndef AbstractClass2_hpp
#define AbstractClass2_hpp

#include "ConcreteClass1.hpp"

struct AbstractClass2 : ConcreteClass1
{
    void g() override = 0; // pure virtual overrider
}; // "AbstractClass2" is abstract

#endif /* AbstractClass2_hpp */
