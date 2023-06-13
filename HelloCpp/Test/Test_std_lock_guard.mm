//
//  Test_std_lock_guard.m
//  Test
//
//  Created by wesley_chen on 2023/6/13.
//

#import <XCTest/XCTest.h>

#include <thread>
#include <mutex>
#include <iostream>

int g_i = 0;
std::mutex g_i_mutex;  // protects g_i
 
void safe_increment()
{
    const std::lock_guard<std::mutex> lock(g_i_mutex);
    ++g_i;
 
    std::cout << "g_i: " << g_i << "; in thread #"
              << std::this_thread::get_id() << '\n';
 
    // g_i_mutex is automatically released when lock
    // goes out of scope
}

@interface Test_std_lock_guard : XCTestCase
@end

@implementation Test_std_lock_guard

- (void)test_std_lock_guard {
    std::cout << "g_i: " << g_i << "; in main()\n";
 
    std::thread t1(safe_increment);
    std::thread t2(safe_increment);
 
    t1.join();
    t2.join();
 
    std::cout << "g_i: " << g_i << "; in main()\n";
}

@end
