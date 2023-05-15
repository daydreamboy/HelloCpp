//
//  ConcreteClass1.hpp
//  Test
//
//  Created by wesley_chen on 2023/5/15.
//

#ifndef ConcreteClass1_hpp
#define ConcreteClass1_hpp

#include "AbstractClass1.hpp"

struct ConcreteClass1 : AbstractClass1
{
    void f() override {}   // non-pure virtual
    void h() override;   // non-pure virtual
    virtual void g() {};      // non-pure virtual
}; // "ConcreteClass1" is non-abstract

#endif /* ConcreteClass1_hpp */
