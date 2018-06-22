//
//  BaseViewController.m
//  AppTest
//
//  Created by wesley_chen on 2018/6/22.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nullable, readwrite) const char *jsonString;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"data1.json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    self.jsonString = [jsonString UTF8String];
}

@end
