//
//  LogMessage.hpp
//  HelloStringIO
//
//  Created by wesley_chen on 2023/1/1.
//

#ifndef LogMessage_hpp
#define LogMessage_hpp

#include <string>
#include <sstream>

namespace wc {

typedef int LogLevel;

const LogLevel WCLOG_DEBUG = 0;
const LogLevel WCLOG_INFO = 1;
const LogLevel WCLOG_WARNING = 2;
const LogLevel WCLOG_ERROR = 3;
const LogLevel WCLOG_FATAL = 4;
const LogLevel WCLOG_NUM_OF_TAGS = 5;

class LogMessage {
public:
    LogMessage(LogLevel level,
               const char *file,
               int line,
               const char *function,
               const char *condition,
               const std::string& content = "");
    ~LogMessage();
    std::ostream& stream() { return _stream; }
    
    bool IsValid() const { return _isValid; }
    void SetValid(bool valid) { _isValid = valid; }
    
private:
    bool _isValid;
    std::ostringstream _stream;
    
    const LogLevel _level;
    const char *_file;
    const char *_function;
    const int _line;
};

/**
 
 - Parameter level: the log level
 */
bool ShouldCreateLogMessage(LogLevel level);

class LogMessageVoidify {
public:
    void operator&(std::ostream&) {}
};

}

#endif /* LogMessage_hpp */
