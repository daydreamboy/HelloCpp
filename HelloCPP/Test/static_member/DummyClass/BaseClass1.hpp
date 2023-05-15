//
//  BaseClass1.hpp
//  Test
//
//  Created by wesley_chen on 2023/5/14.
//

#ifndef BaseClass1_hpp
#define BaseClass1_hpp

#include <memory>

class BaseClass1 {
public:
    static std::shared_ptr<BaseClass1> create();
};

#endif /* BaseClass1_hpp */
