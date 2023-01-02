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

typedef void(*LogMessageHandlerFunction)(int logLevel, const char* message);

struct LogSetting {
    LogLevel minLogLevel = WCLOG_INFO;
    LogMessageHandlerFunction logMessageHandler = nullptr;
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
