//
//  WCCPPTool.m
//  HelloWorld
//
//  Created by wesley_chen on 2021/12/29.
//

#import "WCCPPTool.h"

std::string convertNSDataToCPPString(const NSData* data) {
    if (data == nullptr) {
        return "";
    }

    const char* bytes = (const char *)[data bytes];
    size_t length = [data length];
    std::string s(bytes, length);
    
    return s;
}
