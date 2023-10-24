//
//  WCCPPTool.h
//  HelloWorld
//
//  Created by wesley_chen on 2021/12/29.
//


// OC
#import <Foundation/Foundation.h>

// C++
#include <string>

/**
 Store NSData bytes into std::string style
 
 @param data the NSData object
 
 @return the std::string
 */
std::string convertNSDataToCPPString(const NSData* data);
