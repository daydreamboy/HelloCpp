//
//  ViewController.m
//  AppTest
//
//  Created by wesley chen on 16/4/13.
//
//

#import "ConvertStringToJSONObjectViewController.h"
#include "json.hpp"
#include <iostream>
//#include "nlohmann/json.hpp"

using json = nlohmann::json;
using value_t = nlohmann::detail::value_t;

@interface ConvertStringToJSONObjectViewController ()

@end

@implementation ConvertStringToJSONObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    json jsonObject = json::parse(self.jsonString);
    std::string jsonCPPString = jsonObject.dump();
    NSLog(@"%@", [NSString stringWithUTF8String:jsonCPPString.c_str()]);
    
 
    // parse
    
//    // range-based for
//    for (auto& element : jsonObject) {
//        std::cout << element << '\n' << '\n';
//    }
    
    //jsonObject.type();
    
    //value_t type = jsonObject.type();
    
//    std::cout << jsonObject.type() << std::endl;
    
    // special iterator member functions for objects
    for (json::iterator it = jsonObject.begin(); it != jsonObject.end(); ++it) {
        std::cout << it.key() << " : " << it.value() << "\n";
    }

}

@end
