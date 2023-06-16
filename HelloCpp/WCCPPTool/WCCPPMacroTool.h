//
//  WCCPPMacroTool.h
//  HelloWorld
//
//  Created by wesley_chen on 2021/12/29.
//

#ifndef WCCPPMacroTool_h
#define WCCPPMacroTool_h

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


#pragma mark - Test Value Categories

template<typename T> constexpr const char *__category = "prvalue";
template<typename T> constexpr const char *__category<T&> = "lvalue";
template<typename T> constexpr const char *__category<T&&> = "xvalue";

/**
 Test the expression belong to which value category (prvalue/lvalue/xvalue)
 
 @param E the expression
 
 @discussion This macro will print the value category
 @see https://www.scs.stanford.edu/~dm/blog/decltype.html
 */
#define SHOW_VALUE_CATEGORY(E) std::cout << #E << ": " << __category<decltype((E))> << std::endl

#endif /* WCCPPMacroTool_h */
