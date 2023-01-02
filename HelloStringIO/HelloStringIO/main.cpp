//
//  main.cpp
//  HelloStringIO
//
//  Created by wesley_chen on 2023/1/1.
//

#include <iostream>

#include "LogMessageMacro.h"

int main(int argc, const char * argv[]) {
    std::cout << "Hello, World!\n";
    
    WCLogDebug << "This is a debug message";
    
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    //logSetting.logMessageHandler = CustomLogHandler;
    ::wc::SetLogSetting(logSetting);
#else
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_INFO;
    //logSetting.logMessageHandler = CustomLogHandler;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
    
    return 0;
}
