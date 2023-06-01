//
//  Test_lambda_expression.m
//  Test
//
//  Created by wesley_chen on 2023/1/7.
//

#import <XCTest/XCTest.h>

#include <vector>
#include <iostream>
#include <algorithm>

void printVector(std::vector<int> v)
{
    // lambda expression to print vector
    for_each(v.begin(), v.end(), [](int i)
    {
        std::cout << i << " ";
    });
    std::cout << std::endl;
}

@interface Test_lambda_expression : XCTestCase

@end

@implementation Test_lambda_expression

// Example code from https://www.geeksforgeeks.org/lambda-expression-in-c/
- (void)test_lambda_expression_work_with_algorithm_function_as_parameter {
    std::vector<int> v {4, 1, 3, 5, 2, 3, 1, 7};
 
    // Case 1:
    printVector(v);
 
    // Case 2:
    std::vector<int>::iterator p = find_if(v.begin(), v.end(), [](int i)
    {
        return i > 10;
    });
    
    if (p != std::end(v)) {
        std::cout << "First number greater than 4 is : " << *p << std::endl;
    }
    else {
        std::cout << "First number greater than 4 not found " << std::endl;
    }
}

// Example code from https://www.geeksforgeeks.org/lambda-expression-in-c/
- (void)test_named_lambda_expression {
    auto square = [](int i)
    {
        return i * i;
    };
 
    std::cout << "Square of 5 is : " << square(5) << std::endl;
}

- (void)test_lambda_expression_capture_list_by_reference {
    std::vector<int> v1 = {3, 1, 7, 9};
    std::vector<int> v2 = {10, 2, 7, 16, 9};
 
    //  access v1 and v2 by reference
    auto pushinto = [&] (int m)
    {
        v1.push_back(m);
        v2.push_back(m);
    };
    
    // it pushes 20 in both v1 and v2
    pushinto(20);
    
    printVector(v1);
    printVector(v2);
}

- (void)test_lambda_expression_capture_list_by_copy {
    std::vector<int> v1 = {3, 1, 7, 9};
    std::vector<int> v2 = {10, 2, 7, 16, 9};
 
    //  access v1 and v2 by copy
    auto pushinto = [=] (int m)
    {
        auto v1_copy = v1;
        v1_copy.push_back(m);
        
        // Compile Error: No matching member function for call to 'push_back'
        //v2.push_back(m);
    };
    
    // it pushes 20 in both v1 and v2
    pushinto(20);
    
    printVector(v1);
}

- (void)test_lambda_expression_capture_list_by_copy_mutable {
    std::vector<int> v1 = {3, 1, 7, 9};
    std::vector<int> v2 = {10, 2, 7, 16, 9};
 
    //  access v1 and v2 by copy
    auto pushinto = [=] (int m) mutable
    {
        auto v1_copy = v1;
        v1_copy.push_back(m);
        
        // Note: use mutable fix compile error: No matching member function for call to 'push_back'
        // @see https://stackoverflow.com/questions/36721920/no-matching-member-function-error-inside-lambda-expression
        v2.push_back(m);
    };
    
    // try to pushes 20 in both v1 and v2
    pushinto(20);
    
    printVector(v1);
    printVector(v2);
}

// Example code from https://www.geeksforgeeks.org/lambda-expression-in-c/
- (void)test_lambda_expression_capture_list_specify_variable {
    
    // Case1
    std::vector<int> v1 = {3, 1, 7, 9};
    // access v1 by copy
    auto printV1 = [v1]()
    {
        for (auto p = v1.begin(); p != v1.end(); p++)
        {
            std::cout << *p << " ";
        }
        
        std::cout << std::endl;
    };
    
    printV1();
    
    // Case2
    int N = 5;
    std::vector<int>::iterator p = find_if(v1.begin(), v1.end(), [N](int i)
    {
        return i > N;
    });
    
    if (p != std::end(v1)) {
        std::cout << "First number greater than 5 is : " << *p << std::endl;
    }
    else {
        std::cout << "First number greater than 5 not found" << std::endl;
    }
    
    // Case3
    auto pushinto = [&v1] (int m)
    {
        v1.push_back(m);
    };
    
    // it pushes 20 in both v1 and v2
    pushinto(20);
    printVector(v1);
}

- (void)test_lambda_expression_capture_list_initialize_variable {
    int x = 4;
     
    auto y = [&r = x, x = x + 1]() -> int
    {
        r += 2;
        return x * x;
    }(); // updates ::x to 6 and initializes y to 25.
    
    std::cout << "x: " << x << std::endl;
    std::cout << "y: " << y << std::endl;
}

@end
