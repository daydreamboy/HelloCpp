//
//  LogMessageMacro.h
//  HelloStringIO
//
//  Created by wesley_chen on 2023/1/2.
//

#ifndef LogMessageMacro_h
#define LogMessageMacro_h

#include "LogMessage.hpp"
#include "LogSetting.hpp"

#define WCLogLazyStream(stream, condition) \
!(condition) ? (void)0 : ::wc::LogMessageVoidify() & (stream)

#define WCLogStream(level) \
::wc::LogMessage(::wc::WCLOG_##level, __FILE__, __LINE__, __PRETTY_FUNCTION__, nullptr).stream()

#define WCLogIsOn(level) \
  (::wc::ShouldCreateLogMessage(::wc::WCLOG_##level))

#define WCLOG(level) \
WCLogLazyStream(WCLogStream(level), WCLogIsOn(level))


#pragma mark - Log Suite

#define WCLogDebug \
WCLogLazyStream(WCLogStream(DEBUG), WCLogIsOn(DEBUG))

#define WCLogInfo \
WCLOG(INFO)

#define WCLogWarning \
WCLOG(WARNING)

#define WCLogError \
WCLOG(ERROR)

#define WCLogFatal \
WCLOG(FATAL)

#endif /* LogMessageMacro_h */
