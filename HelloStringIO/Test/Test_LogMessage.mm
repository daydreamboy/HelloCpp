//
//  Test_LogMessage.m
//  Test
//
//  Created by wesley_chen on 2023/1/2.
//

#import <XCTest/XCTest.h>
#include "LogMessageMacro.h"

@interface Test_LogMessage : XCTestCase

@end

@implementation Test_LogMessage

void CustomLogMessageHandler(int logLevel, const char* message)
{
    NSLog(@"%s", message);
}

- (void)test_log {
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    //logSetting.logMessageHandler = CustomLogHandler;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message" << ", param: something";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
}

- (void)test_use_logMessageHandler {
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    logSetting.logMessageHandler = CustomLogMessageHandler;
    ::wc::SetLogSetting(logSetting);
#else
    wc::LogSetting logSetting;
    logSetting.logMessageHandler = CustomLogMessageHandler;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message" << ", param: something";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
}

- (void)test_flags_showCallerFunction {
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    logSetting.showCallerFunction = false;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message" << ", param: something";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
}

- (void)test_flags_showOrderNumber {
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    logSetting.showOrderNumber = false;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message" << ", param: something";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
}

- (void)test_flags_showSourceFileLocation {
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    logSetting.showSourceFileLocation = false;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message" << ", param: something";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
}

- (void)test_flags_showTimestamp {
#if DEBUG
    wc::LogSetting logSetting;
    logSetting.minLogLevel = ::wc::WCLOG_DEBUG;
    logSetting.showTimestamp = false;
    ::wc::SetLogSetting(logSetting);
#endif
    
    WCLogDebug << "This is a second debug message" << ", param: something";
    WCLogInfo << "This is a info message";
    WCLogWarning << "This is a warning message";
    WCLogError << "This is an error message";
    WCLogFatal << "This is a fatal message";
}

@end
