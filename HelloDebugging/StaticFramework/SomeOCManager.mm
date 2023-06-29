//
//  SomeOCManager.m
//  StaticFramework
//
//  Created by wesley_chen on 2023/6/29.
//

#import "SomeOCManager.h"

#import "SomeManager_c_api.h"

@implementation SomeOCManager

+ (instancetype)sharedInstance {
    static SomeOCManager *sInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [SomeOCManager new];
    });
    
    return sInstance;
}

- (void)startWithConfig:(NSDictionary *)config {
    SHORT_NAMESPACE::SomeManagerPtr cppManager = CreateSomeManager();
    cppManager->Start(1);
}

@end
