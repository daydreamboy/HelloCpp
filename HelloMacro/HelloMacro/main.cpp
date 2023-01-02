//
//  main.cpp
//  HelloMacro
//
//  Created by wesley_chen on 2023/1/1.
//

#include <iostream>
#include <string>
#include <sstream>

#include "wc_macro.h"

/// LogMessage1

class LogMessage1 {
public:
    LogMessage1(const std::string& content = "");
private:
    std::ostringstream _stream;
};

LogMessage1::LogMessage1(const std::string& content)
{
    _stream << content;
    _stream << std::endl;
}

/// LogMessage2

class LogMessage2 {
public:
    LogMessage2(const std::string& content = "");
    WC_DISALLOW_COPY_AND_ASSIGN(LogMessage2);
private:
    std::ostringstream _stream;
};

LogMessage2::LogMessage2(const std::string& content)
{
    _stream << content;
    _stream << std::endl;
}


int main(int argc, const char * argv[]) {
    LogMessage1 m1 = LogMessage1("This is message 1");
    LogMessage1 &anotherOfM1 = m1;
    
    LogMessage2 m2 = LogMessage2("This is message 2");
    LogMessage2 &anotherOfM2 = m2;
    
    std::cout << "main func is over" << std::endl;
    
    return 0;
}
