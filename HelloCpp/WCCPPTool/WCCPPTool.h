//
//  WCCPPTool.h
//  HelloWorld
//
//  Created by wesley_chen on 2021/12/29.
//

#include <iostream>
#include <typeinfo>
#include <cxxabi.h>

// Note: use extern "C++" instead of extern "C"
// see https://dawnarc.com/2019/07/c-error-templates-must-have-c-linkage/
extern "C++"  {

/**
 Dump object info
 
 @param object the C/C++ object
 
 @discussion If you need to dump type, try to use WCDumpType macro
 */
template<typename T>
void WCDumpObject(const T& object) {
    const std::type_info& ti = typeid(T);
    int status;
    char* demangled_name = abi::__cxa_demangle(ti.name(), nullptr, nullptr, &status);
    if (status == 0) {
        std::cout << object << " = " << demangled_name << std::endl;
        free(demangled_name);
    } else {
        std::cerr << "[WCDumpObject] " << ti.name() << ", error: " << status << std::endl;
    }
}

} // extern "C"

