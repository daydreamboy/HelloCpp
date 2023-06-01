//
//  ViewController.m
//  HelloWorld
//
//  Created by wesley_chen on 2023/6/1.
//

#import "BlockCaptureThisPointerViewController.h"

#include <iostream>

class Test_block_DummyClass {
public:
    NSObject *memberData;
    void func1(void);
    void func2(void);
};

void Test_block_DummyClass::func1()
{
    std::cout << "func1() called" << std::endl;
    
    [NSThread detachNewThreadWithBlock:^{
        func2();
    }];
}

void Test_block_DummyClass::func2()
{
    std::cout << "func2() called" << std::endl;
    
    // Case 1
    //this->memberData;
    if (memberData != nil) {
        NSLog(@"%p", memberData);
        
        // Case 2
        NSLog(@"%@", memberData);
        
        // Case 3
        memberData = [NSObject new];
        
        std::cout << "memberData is not nil" << std::endl;
    }
    std::cout << "passed the check" << std::endl;
}

@interface BlockCaptureThisPointerViewController ()
@end

@implementation BlockCaptureThisPointerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self test_block_capture_this_pointer];
    [self test_block_capture_this_pointer_2];
}

- (void)test_block_capture_this_pointer_2 {
    Test_block_DummyClass ptr = Test_block_DummyClass();
    ptr.func1();
}

- (void)test_block_capture_this_pointer {
    Test_block_DummyClass *ptr = new Test_block_DummyClass();
    ptr->func1();
    delete ptr;
}

@end
