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
 
 @param type_ the C++ type
 
 @header
 #include <iostream>
 #include <typeinfo>
 #include <cxxabi.h>
 */
#define WCDumpType(type_) \
do { \
    const std::type_info& ti = typeid(type_); \
    int status; \
    char* demangled_name = abi::__cxa_demangle(ti.name(), nullptr, nullptr, &status); \
    if (status == 0) { \
        std::cout <<  #type_ << " = " << demangled_name << std::endl; \
        free(demangled_name); \
    } else { \
        std::cerr << "[WCDumpType] " << ti.name() << ", error: " << status << std::endl; \
    } \
} while (0);

#endif /* WCCPPMacroTool_h */
