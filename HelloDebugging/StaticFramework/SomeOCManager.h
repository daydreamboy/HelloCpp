//
//  SomeOCManager.h
//  StaticFramework
//
//  Created by wesley_chen on 2023/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SomeOCManager : NSObject

+ (instancetype)sharedInstance;
- (void)startWithConfig:(NSDictionary *)config;

@end

NS_ASSUME_NONNULL_END
