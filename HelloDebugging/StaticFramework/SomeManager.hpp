//
//  SomeManager.hpp
//  StaticFramework
//
//  Created by wesley_chen on 2023/6/29.
//

#ifndef SomeManager_hpp
#define SomeManager_hpp

#include <memory>

#define SHORT_NAMESPACE some::name

#define SHORT_NAMESPACE_BEGIN \
namespace some { \
namespace name {

#define SHORT_NAMESPACE_END \
} \
}

SHORT_NAMESPACE_BEGIN

class SomeManager {
public:
    void Start(int type);
};

using SomeManagerPtr = std::shared_ptr<SomeManager>;

SHORT_NAMESPACE_END

#endif /* SomeManager_hpp */
