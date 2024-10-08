//
//  LogMessage.cpp
//  HelloStringIO
//
//  Created by wesley_chen on 2023/1/1.
//

#include "LogMessage.hpp"
#include "LogSetting.hpp"

#include <iostream>
#include <sys/time.h>

namespace wc {

const char* const kLogTagNames[WCLOG_NUM_OF_TAGS] = {
    "DEBUG", "INFO", "WARNING", "ERROR", "FATAL"
};

const char* GetLogTagForLogLevel(LogLevel level) {
    if (level >= WCLOG_DEBUG && level < WCLOG_NUM_OF_TAGS) {
        return kLogTagNames[level];
    }
    return "UNKNOWN";
}

const char* StripDots(const char* path) {
    while (strncmp(path, "../", 3) == 0) {
        path += 3;
    }
    return path;
}

const char* StripPath(const char* path) {
    auto* p = strrchr(path, '/');
    if (p) {
        return p + 1;
    }
    else {
        return path;
    }
}

bool ShouldCreateLogMessage(LogLevel level) {
    return level >= GetMinLogLevel();
}

static long long unsigned sOrder;

LogMessage::LogMessage(LogLevel level,
                       const char *file,
                       int line,
                       const char *function,
                       const std::string& content) : _isValid(true), _level(level), _file(file), _line(line),  _function(function)
{
    if (_file == nullptr) {
        _file = "";
    }
    
    const char *fileName = ((strrchr(_file, '/') ?: _file - 1) + 1);
    
    // Note: componentable log message
    // full format for printf: @"%s %llu:[%s][%s:%d]`%s: %s"
    // 2022-12-12 11:01:14.923000+0800 1:[DEBUG][PrintLogInCFunctionsViewController.m:18]`void callAFunction(NSString *__strong): a test for calling c function with `some parameters`
    
    if (GetLogSetting().showTimestamp) {
        char fmt[64], buf[64];
        struct timeval tv;
        struct tm *tm;

        gettimeofday(&tv, NULL);
        if ((tm = localtime(&tv.tv_sec)) != NULL) {
            strftime(fmt, sizeof fmt, "%Y-%m-%d %H:%M:%S.%%06u%z", tm);
            snprintf(buf, sizeof buf, fmt, tv.tv_usec);
        }
        
        if (std::strlen(buf) > 0) {
            _stream << buf << " ";
        }
    }
    
    if (GetLogSetting().showOrderNumber) {
        _stream << sOrder++ << ":";
    }
    
    _stream << "[";
    _stream << GetLogTagForLogLevel(_level);
    _stream << "]";
    
    if (GetLogSetting().showSourceFileLocation) {
        _stream << "[" << fileName << ":" << _line << "]";
    }
    
    if (GetLogSetting().showCallerFunction) {
        _stream << "`" << _function << ":";
    }
    
    _stream << " ";
    
    if (!content.empty()) {
        _stream << content;
    }
}

LogMessage::~LogMessage()
{
    if (!_isValid || !ShouldCreateLogMessage(_level)) {
        return;
    }

    _stream << std::endl;

    if (GetLogMessageHandler()) {
        GetLogMessageHandler()(_level, _stream.str().c_str());
    }
    else {
        std::cerr << _stream.str();
        std::cerr.flush();
    }
}

} // namespace wc
