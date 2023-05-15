//
//  DefineStaticMember.hpp
//  Test
//
//  Created by wesley_chen on 2023/5/15.
//

#ifndef DefineStaticMember_hpp
#define DefineStaticMember_hpp

struct Foo;
 
struct S
{
    static int a[]; // declaration, incomplete type
    static Foo x;   // declaration, incomplete type
    static S s;     // declaration, incomplete type (inside its own definition)
};

#pragma mark - X2

struct X2
{
    static void f(); // declaration
    static int n;    // declaration
};

#endif /* DefineStaticMember_hpp */
