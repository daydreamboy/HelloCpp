//
//  WCCPPMacroTool.h
//  HelloWorld
//
//  Created by wesley_chen on 2021/12/29.
//

#ifndef WCCPPMacroTool_h
#define WCCPPMacroTool_h

#include <iostream>
#include <typeinfo>
#include <cxxabi.h>

/// The macros in this file used for .mm files

/**
 Create a std::striing from NSString
 
 @param nsString_ the NSStirng. If nil, return empty string instead
 
 @return the std::striing
 
 @see https://stackoverflow.com/questions/8001677/how-do-i-convert-a-nsstring-into-a-stdstring
 */
#define CPPStringFromNSString(nsString_) std::string([(nsString_) UTF8String] ?: "")

/**
 Create a NSString from std::string
 
 @param cppString_ the std::string
 
 @return the NSString. If any error occurred, return @"" instead
 
 @see https://stackoverflow.com/a/7424962
 */
#define NSStringFromCPPString(cppString_) \
({ \
NSString *returnedString_ = @""; \
const char *cString_ = cppString_.c_str(); \
if (cString_ != NULL) { \
    returnedString_ = [[NSString alloc] initWithUTF8String:cString_]; \
} \
returnedString_; \
})

#pragma mark - WCDumpType

/**
 Dump type info for C++ type, e.g. std::string, int, ...
 
 @param ... the C++ type
 
 @header
 #include <iostream>
 #include <typeinfo>
 #include <cxxabi.h>
 */
#define WCDumpType(...) \
do { \
    const std::type_info& ti = typeid(__VA_ARGS__); \
    int status; \
    char* demangled_name = abi::__cxa_demangle(ti.name(), nullptr, nullptr, &status); \
    if (status == 0) { \
        std::cout <<  #__VA_ARGS__ << " = " << demangled_name << std::endl; \
        free(demangled_name); \
    } else { \
        std::cerr << "[WCDumpType] " << ti.name() << ", error: " << status << std::endl; \
    } \
} while (0);

#pragma mark - WCDumpObject

// Note: use extern "C++" instead of extern "C"
// see https://dawnarc.com/2019/07/c-error-templates-must-have-c-linkage/
extern "C++"  {

/**
 Dump object info
 
 @param rawString the plain string expected as an expression
 @param value the C/C++ value
 @param isLvalueRef the flag for lvalue reference
 @param isRvalueRef the flag for rvalue reference
 
 @header
 #include <iostream>
 #include <typeinfo>
 #include <cxxabi.h>
 
 @discussion If you need to dump type, try to use WCDumpType macro
 */
template<typename T>
void __WCDumpObject(std::string&& rawString, const T& value, bool isLvalueRef, bool isRvalueRef) {
    const std::type_info& ti = typeid(T);
    int status;
    char* demangled_name = abi::__cxa_demangle(ti.name(), nullptr, nullptr, &status);
    if (status == 0) {
        std::cout << rawString << " = " << value << " (" << demangled_name << ((isLvalueRef || isRvalueRef) ? (isLvalueRef ? "&": "&&"): "") << ")" << std::endl;
        free(demangled_name);
    } else {
        std::cerr << "[WCDumpObject] " << ti.name() << ", error: " << status << std::endl;
    }
}

} // extern "C"

#define WCDumpObject(expression)\
__WCDumpObject(#expression, expression, std::is_lvalue_reference_v<decltype(expression)>, std::is_rvalue_reference_v<decltype(expression)>)


#pragma mark - Test Value Categories

template<typename T> constexpr const char *__category = "prvalue";
template<typename T> constexpr const char *__category<T&> = "lvalue";
template<typename T> constexpr const char *__category<T&&> = "xvalue";

/**
 Test the expression belong to which value category (prvalue/lvalue/xvalue)
 
 @param ... the expression
 
 @discussion This macro will print the value category
 @see https://www.scs.stanford.edu/~dm/blog/decltype.html
 */
#define SHOW_VALUE_CATEGORY(...) std::cout << #__VA_ARGS__ << ": " << __category<decltype((__VA_ARGS__))> << std::endl

#endif /* WCCPPMacroTool_h */
