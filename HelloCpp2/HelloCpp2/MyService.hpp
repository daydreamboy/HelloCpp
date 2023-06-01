//
//  MyService.hpp
//  HelloWorld
//
//  Created by wesley_chen on 2020/7/27.
//

#ifndef MyService_hpp
#define MyService_hpp

#include <string>

namespace company {
namespace SDK {

class MyService {
public:
    //virtual void Request(con***st std::string& name) = 0;
    void Request(const std::string& name);
};

using MyServicePtr = std::shared_ptr<MyService>;

} // SDK
} // company

#endif /* MyService_hpp */
