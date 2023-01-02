//
//  LogSetting.hpp
//  HelloStringIO
//
//  Created by wesley_chen on 2023/1/2.
//

#ifndef LogSetting_hpp
#define LogSetting_hpp

#include "LogMessage.hpp"

namespace wc {

typedef void (*LogMessageHandlerFunction)(int logLevel, const char* message);

struct LogSetting {
    /**
     The minimum log level which allow to create log message. Default is INFO.
     */
    LogLevel minLogLevel = WCLOG_INFO;
    /**
     The handler for custom logging
     */
    LogMessageHandlerFunction logMessageHandler = nullptr;
    /**
     The flag for show caller function. Default is true
     */
    bool showCallerFunction = true;
    /**
     The flag for show log message order. Default is true
     */
    bool showOrderNumber = true;
    /**
     The flag for show source file locaiton. Default is true
     */
    bool showSourceFileLocation = true;
};

/**
 Configure the log setting
 
 - Parameter setting: the new setting object
 */
void SetLogSetting(const LogSetting& setting);

LogSetting GetLogSetting();
int GetMinLogLevel();
LogMessageHandlerFunction GetLogMessageHandler();

} // namespace wc

#endif /* LogSetting_hpp */
