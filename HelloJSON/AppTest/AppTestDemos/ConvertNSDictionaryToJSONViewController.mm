//
//  ViewController.m
//  AppTest
//
//  Created by wesley chen on 16/4/13.
//
//

#import "ConvertNSDictionaryToJSONViewController.h"
#include "json.hpp"
//#include "nlohmann/json.hpp"

using json = nlohmann::json;

@interface ConvertNSDictionaryToJSONViewController ()

@end

@implementation ConvertNSDictionaryToJSONViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"data1.json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    json jsonObject = json::parse([jsonString UTF8String]);
    std::string jsonCPPString = jsonObject.dump();
    NSLog(@"%@", [NSString stringWithUTF8String:jsonCPPString.c_str()]);
}

@end
