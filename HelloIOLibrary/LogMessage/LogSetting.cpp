//
//  LogSetting.cpp
//  HelloStringIO
//
//  Created by wesley_chen on 2023/1/2.
//

#include "LogSetting.hpp"

namespace wc {

LogSetting gLogSetting;

void SetLogSetting(const LogSetting& setting)
{
    gLogSetting.minLogLevel = std::min(WCLOG_FATAL, setting.minLogLevel);
    gLogSetting.logMessageHandler = setting.logMessageHandler;
    
    // Set flags
    gLogSetting.showCallerFunction = setting.showCallerFunction;
    gLogSetting.showOrderNumber = setting.showOrderNumber;
    gLogSetting.showSourceFileLocation = setting.showSourceFileLocation;
    gLogSetting.showTimestamp = setting.showTimestamp;
}

LogSetting GetLogSetting() {
    return gLogSetting;
}

int GetMinLogLevel() {
    return std::min(gLogSetting.minLogLevel, WCLOG_FATAL);
}

LogMessageHandlerFunction GetLogMessageHandler() {
    return gLogSetting.logMessageHandler;
}

} // namespace wc
