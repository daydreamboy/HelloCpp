//
//  SomeManagerAPI.c
//  StaticFramework
//
//  Created by wesley_chen on 2023/6/29.
//

#include "SomeManager_c_api.h"

SHORT_NAMESPACE::SomeManagerPtr CreateSomeManager(void) {
    return std::shared_ptr<SHORT_NAMESPACE::SomeManager>();
}
