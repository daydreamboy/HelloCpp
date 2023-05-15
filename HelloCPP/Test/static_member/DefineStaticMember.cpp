//
//  DefineStaticMember.cpp
//  Test
//
//  Created by wesley_chen on 2023/5/15.
//

#include "DefineStaticMember.hpp"

int S::a[10]; // definition, complete type
struct Foo {};
Foo S::x;     // definition, complete type
S S::s;       // definition, complete type

#pragma mark - X2

X2 g() { return X2(); } // some function returning X2
 
void f()
{
    X2::f();  // X2::f is a qualified name of static member function
    g().f(); // g().f is member access expression referring to a static member function
}
 
int X2::n = 7; // definition
 
void X2::f() // definition
{
    n = 1; // X2::n is accessible as just n in this scope
}
