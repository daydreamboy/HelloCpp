# Learn C++

[TOC]

## 1、前言

本文目录结构参考[cppreference.com](https://en.cppreference.com/)提供的目录[^5]



## 2、lambda表达式

lambda表达式是指匿名的函数对象，支持在其作用域内捕获变量。

官方文档对lambda表达式描述[^1]，如下

> Constructs a [closure](https://en.wikipedia.org/wiki/Closure_(computer_science)): an unnamed function object capable of capturing variables in scope.

说明

>在C++ 11开始支持lambda表达式



### (1) lambda表达式的签名

官方文档对lambda表达式的签名定义，如下

| 函数签名                                                     | 序号 | C++版本                         |
| ------------------------------------------------------------ | ---- | ------------------------------- |
| [ captures ] ( params ) specs requires(optional) { body }    | (1)  |                                 |
| [ captures ] { body }                                        | (2)  | (until C++23)                   |
| [ captures ] specs { body }                                  | (2)  | (since C++23)                   |
| [ captures ] < tparams > requires(optional) ( params ) specs requires(optional) { body } | (3)  | (since C++20)                   |
| [ captures ] < tparams > requires(optional) { body }         | (4)  | (since C++20)<br/>(until C++23) |
| [ captures ] < tparams > requires(optional) specs { body }   | (4)  | (since C++23)                   |

lambda表达式的签名有很多种，这里只介绍最常用的签名，即(1)类型

```
[ captures ] ( params ) specs requires(optional) { body }
```

参数释义

* captures，捕获变量列表，使用`,`分隔
* params，lambda表达式的参数列表，和一般的函数参数列表是一样的
* specs，描述列表，包含specifiers, exception, attr和trailing-return-type这4种组件，每个组件都是可选的。
  * specifiers，可以是mutable关键词等
  * exception，TODO
  * attr，TODO
  * trailing-return-type，即`-> returnType`格式，表示lambda表达式的返回类型
* requires，TODO
* body，lambda表达式的函数体

了解了上面最常用的lambda表达式的签名，即表格中的(1)类型，可以重新定义下lambda表达式的语法格式，如下

```
[ capture list ] (parameters) -> return-type  
{   
   definition of method   
}
```



### (2) 使用lambda表达式

lambda表达式的用法，有下面几种

* 作为函数的参数
* 定义lambda变量



#### a. 作为函数的参数

在`<algorithm>`中提供很多工具函数，都支持lambda表达式作为参数。

举个例子，如下

```c++
void printVector(std::vector<int> v)
{
    // lambda expression to print vector
    for_each(v.begin(), v.end(), [](int i)
    {
        std::cout << i << " ";
    });
    std::cout << std::endl;
}
```

上面for_each的第三个参数可以是一个lambda表达式，遍历每个元素时，for_each函数内部都会调用lambda表达式。



#### b. 定义lambda变量

使用lambda表达式赋值给C++变量，这个变量就变成lambda变量，可以使用这个变量当成函数调用来使用。

举个例子，如下

```objective-c
- (void)test_named_lambda_expression {
    auto square = [](int i)
    {
        return i * i;
    };
 
    std::cout << "Square of 5 is : " << square(5) << std::endl;
}
```



### (3) lambda表达式的capture列表

上面介绍lambda表达式的签名，提到capture列表，即捕获变量列表。这节详细介绍下capture列表的用法。

capture列表有两种类型的默认捕获(capture-default)，分别使用特定符号`&`和`=`。

* `&`，表示默认按照引用方式，捕获作用域中变量
* `=`，表示默认按照值拷贝方式，捕获作用域中变量

官方文档描述[^1]，如下

> The only capture defaults are
>
> - `&` (implicitly capture the used automatic variables by reference) and
> - `=` (implicitly capture the used automatic variables by copy).



#### a. `&`按引用捕获

capture列表，如果只使用`&`，表示lambda表达式作用域内的变量默认按照引用捕获。

举个例子，如下

```c++
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
```

由于是按照引用捕获变量v1和v2，则调用push_back函数，可以将原始vector数组添加元素20。



#### b. `=`按值拷贝捕获

capture列表，如果只使用`=`，表示lambda表达式作用域内的变量默认按照值拷贝捕获。

举个例子，如下

```c++
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
```

上面使用`=`的值拷贝方式，在pushinto表达式中，没有判断出v2的类型，所以识别不了它的成员函数push_back。这里为了演示，采用临时变量v1_copy，用它调用push_back函数。使用printVector打印v1变量，可以看出pushinto(20)没有向原始vector数组v1添加元素20。v1_copy变量确实是v1的一个值拷贝对象。



#### c. 指定变量捕获

在capture列表中指定变量捕获，在官方文档[^1]有下面几种形式：

| 格式                         | 序号 | C++版本       |
| ---------------------------- | ---- | ------------- |
| identifier                   | (1)  |               |
| identifier ...               | (2)  |               |
| identifier initializer       | (3)  | (since C++14) |
| & identifier                 | (4)  |               |
| & identifier ...             | (5)  |               |
| & identifier initializer     | (6)  | (since C++14) |
| this                         | (7)  |               |
| * this                       | (8)  | (since C++17) |
| ... identifier initializer   | (9)  | (since C++20) |
| & ... identifier initializer | (10) | (since C++20) |

每种格式的含义，如下

(1) simple by-copy capture

(2) simple by-copy capture that is a [pack expansion](https://en.cppreference.com/w/cpp/language/parameter_pack)

(3) by-copy capture with an [initializer](https://en.cppreference.com/w/cpp/language/initialization)

(4) simple by-reference capture

(5) simple by-reference capture that is a [pack expansion](https://en.cppreference.com/w/cpp/language/parameter_pack)

(6) by-reference capture with an initializer

(7) simple by-reference capture of the current object

(8) simple by-copy capture of the current object

(9) by-copy capture with an initializer that is a pack expansion

(10) by-reference capture with an initializer that is a pack expansion



这里列举几个常用格式的例子[^4]，如下

```c++
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
```



在capture列表中可以定义变量并初始化，举个例子[^1]，如下

```c++
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

```

* 上面r变量是x变量的引用，对r变量的修改，等价是修改x变量
* capture列表的第2个变量x，是新的变量，不同于int x=4中x变量，x*x实际是5 * 5，并将值赋值给y



#### d. 没有变量捕获

如果没有变量捕获，则capture列表可以为空。

举个例子，如下

```c++
auto square = [](int i)
{
    return i * i;
};

std::cout << "Square of 5 is : " << square(5) << std::endl;
```



#### e. pack expansion

TODO: https://learn.microsoft.com/en-us/cpp/cpp/lambda-expressions-in-cpp?view=msvc-170





## 3、string库

### (1) std::string

std::string有下面几种初始化方式

* 从const char*初始化

```c++
// Creating a string from const char*     
std::string str1 = "hello";
std::string str2 = std::string("hello");
```

* 字面量初始化

```c++
using namespace std::literals;
auto cppString2 = "中文"s;
std::cout << cppString2 << std::endl;
```

注意

> 字面量字符串带后缀s，并且配合using namespace std::literals;使用，否则auto推断的类型会不准确，导致调用这个变量的方法时，可能会有编译错误。



### (2) String IO

`ostringstream`是`basic_ostringstream<char>`的别名，它定义在`<sstream>`头文件中。作用是存放输出字符串。

举个例子，如下

```c++
- (void)test_std_ostringstream {
    std::ostringstream stream;
    
    stream << "Hello, " << "ostring" << "stream";
    stream << std::endl;
    
    std::string string = stream.str();
    const char* s = string.c_str();
    
    printf("%s", s);
}
```



## 4、algorithm库

algorithm库提供一些常用的工具函数。

导入头文件方式：`#include <algorithm>`



### (1) 常用的工具函数

| 函数名   | 作用                     |
| -------- | ------------------------ |
| for_each | 遍历list容器，例如vector |



#### a. for_each函数

for_each函数的签名如下

| 函数签名                                                     | 序号 | C++版本       |
| ------------------------------------------------------------ | ---- | ------------- |
| template< class InputIt, class UnaryFunction ><br/>UnaryFunction for_each( InputIt first, InputIt last, UnaryFunction f ); | (1)  | (until C++20) |
| template< class InputIt, class UnaryFunction ><br/>constexpr UnaryFunction for_each( InputIt first, InputIt last, UnaryFunction f ); | (1)  | (since C++20) |
| template< class ExecutionPolicy, class ForwardIt, class UnaryFunction2 ><br/>void for_each( ExecutionPolicy&& policy, ForwardIt first, ForwardIt last, UnaryFunction2 f ); | (2)  | (since C++17) |

Xcode的libc++实现，如下

```c++
template <class _InputIterator, class _Function>
inline _LIBCPP_INLINE_VISIBILITY _LIBCPP_CONSTEXPR_AFTER_CXX17 _Function for_each(_InputIterator __first,
                                                                                  _InputIterator __last,
                                                                                  _Function __f) {
  for (; __first != __last; ++__first)
    __f(*__first);
  return __f;
}
```



举个例子，如下

```c++
void printVector(std::vector<int> v)
{
    // lambda expression to print vector
    for_each(v.begin(), v.end(), [](int i)
    {
        std::cout << i << " ";
    });
    std::cout << std::endl;
}
```





## 5、concurrency库

concurrency库是C++提供内置的能力，用于支持threads、atomic operations、mutual exclusion、condition variable等等。

官方文档对concurrency库的描述[^2]，如下

> C++ includes built-in support for threads, atomic operations, mutual exclusion, condition variables, and futures.

说明

> 从C++ 11开始支持concurrency库



### (1) Threads

TODO



### (2) Atomic operations

TODO



### (3) Mutual exclusion

#### a. call_once函数

导入头文件方式：`#include <mutex>`

call_once函数的签名如下

| 函数签名                                                     | 序号 | C++版本       |
| ------------------------------------------------------------ | ---- | ------------- |
| template< class Callable, class... Args ><br/>void call_once( [std::once_flag](http://en.cppreference.com/w/cpp/thread/once_flag)& flag, Callable&& f, Args&&... args ); | (1)  | (since C++11) |

call_once函数的作用是即使来自不同线程同时调用call_once函数，call_once函数也会保证f对象只被调用一次。

官方文档描述[^3]，如下

> Executes the [*Callable*](https://en.cppreference.com/w/cpp/named_req/Callable) object `f` exactly once, even if called concurrently, from several threads.



call_once可以使用lambda表达式作为参数。

举个例子，如下

```c++
std::once_flag flag1;
 
void simple_do_once()
{
    std::call_once(flag1, [](){ std::cout << "Simple example: called once\n"; });
}

- (void)test_call_once_with_lambda_expression {
    std::thread st1(simple_do_once);
    std::thread st2(simple_do_once);
    std::thread st3(simple_do_once);
    std::thread st4(simple_do_once);
    st1.join();
    st2.join();
    st3.join();
    st4.join();
}
```

上面创建4个线程，同时调用simple_do_once函数，但是lambda表达式仅执行一次。



call_once可以使用回调函数作为参数。

举个例子，如下

```c++
std::once_flag flag2;

void may_throw_function(bool do_throw)
{
    if (do_throw) {
        std::cout << "throw: call_once will retry\n"; // this may appear more than once
        throw std::exception();
    }
    std::cout << "Didn't throw, call_once will not attempt again\n"; // guaranteed once
}

void do_once(bool do_throw)
{
    try {
        std::call_once(flag2, may_throw_function, do_throw);
    }
    catch (...) {
    }
}

- (void)test_call_once_with_callback_function {
    std::thread t1(do_once, true); // cause to throw exception
    std::thread t2(do_once, true); // cause to throw exception
    std::thread t3(do_once, false);
    std::thread t4(do_once, true); // cause to throw exception
    t1.join();
    t2.join();
    t3.join();
    t4.join();
}
```

上面创建4个线程，同时调用may_throw_function函数，需要说明的是这个函数可能会抛出异常。

如果在call_once函数的Callable&& f中存在异常抛出，则会导致flag参数，没有正确被设置，那么这次call_once函数调用属于异常情况，下次调用call_once函数，还是进行一次对f参数调用。这种情况下，call_once函数不能保证只调用一次。

在上面有三个异常抛出，可能的输出结果是

```
throw: call_once will retry
throw: call_once will retry
Didn't throw, call_once will not attempt again
```

有两次throw: call_once will retry输出，说明call_once函数保证只调用一次已经失效。在输出Didn't throw, call_once will not attempt again后，call_once函数才生效，后续重复调用call_once函数，则不会调用Callable&& f



说明

> 针对call_once函数可能失效的情况，需要在Callable&& f的内部，使用try-catch提前处理好异常情况，这样保证call_once函数能正常工作。



##### 使用call_once函数创建一个单例

call_once函数的常见用途，就是创建一个单例。举个例子，如下

```c++
class MyClass {
public:
    static MyClass *shared_instance() {
        static MyClass *sharedInstance = nullptr;
        static std::once_flag oc;
        std::call_once(oc, [&] {
            try {
                if (sharedInstance == nullptr) {
                    sharedInstance = new MyClass();
                }
            }
            catch (...) {
            }
        });
        
        return sharedInstance;
    }
};

void get_shared_instance()
{
    auto sharedInstance = MyClass::shared_instance();
    
    // Warning: \n will not correct output when multi-thread
    //std::cout << sharedInstance << std::endl;
    
    std::ostringstream stream;
    stream << sharedInstance << std::endl;
    
    std::string string = stream.str();
    const char* s = string.c_str();
    
    printf("%s", s);
}

- (void)test_call_once_for_shared_instance {
    std::thread st1(get_shared_instance);
    std::thread st2(get_shared_instance);
    std::thread st3(get_shared_instance);
    std::thread st4(get_shared_instance);
    st1.join();
    st2.join();
    st3.join();
    st4.join();
}
```

上面创建4个线程，同时获取单例，由于call_once函数，保证获取都是同一个单例对象，打印的对象地址是相同的。



### (4) Condition variables

TODO





## 6、utilities库

### (1) std::bind

std::bind函数的签名，如下

| 函数签名                                                     | 序号 | C++版本                          |
| ------------------------------------------------------------ | ---- | -------------------------------- |
| template< class F, class... Args ><br/>/\*unspecified\*/ bind( F&& f, Args&&... args ); | (1)  | (since C++11) <br/>(until C++20) |
| template< class F, class... Args ><br/>constexpr */\*unspecified\*/* bind( F&& f, Args&&... args ); | (1)  | (since C++20)                    |
| template< class R, class F, class... Args ><br/>/\*unspecified\*/ bind( F&& f, Args&&... args ); | (2)  | (since C++11) <br/>(until C++20) |
| template< class R, class F, class... Args ><br/>constexpr /\*unspecified\*/ bind( F&& f, Args&&... args ) | (2)  | (since C++20)                    |

定义在`<functional>`头文件中。

std::bind函数的作用是包装已有的函数生成一个函数对象，这个函数对象可以像原始函数那样去调用。

举个简单的例子[^6]，如下

```c++
#include <functional>
#include <iostream>
#include <cassert>

using namespace std;
using namespace std::placeholders;  // for _1, _2, _3...

int add(int first, int second)
{
    printf("first: %d, second: %d\n", first, second);
    return first + second;
}

- (void)test_bind_with_placeholder_parameters {
    // Note: add_func accept two parameters
    auto add_func = std::bind(&add, _1, _2);
    int result = add_func(4, 5);
    std::cout << result << std::endl;
    assert(result == 9);
}
```

std::bind函数的参数，有两部分

* 第一个参数，是Callable对象，例如函数指针等
* 剩余参数，是传递给原始函数的参数，可以是默认值，或者占位变量，例如`_1`、`_2`等

说明

> 1. `_1`、`_2`，定义在std::placeholders命名空间中
> 2. std::bind函数的占位变量的顺序，可以是任意的，这个顺序决定传给原始函数的参数列表



std::bind函数常用的几个用法

* 包装原始函数，方便像闭包一样传递和调用
* 调整调用参数，可以安排参数顺序，设置默认值等
* 配合STL函数使用，很多STL函数支持函数对象







## 7、其他TODO

### (1) using

（1）别名

C++11支持using用于别名

[1] https://stackoverflow.com/a/20791007



### (2) R语法

格式：prefix(optional) R "delimiter( raw_characters )delimiter"

[1] https://en.cppreference.com/w/cpp/language/string_literal



ISSUE

https://stackoverflow.com/questions/8112656/objective-c-blocks-and-c-objects





TODO：

依赖的lib：gmock

依赖的头文件：#include <gmock/gmock.h>

下载地址：https://github.com/google/googletest/archive/refs/tags/release-1.11.0.zip

https://chromium.googlesource.com/external/github.com/google/googletest/+/HEAD/docs/reference/mocking.md



比较2个版本号字符串

C++版本：https://www.geeksforgeeks.org/compare-two-version-numbers/



std::bind函数

https://thispointer.com/stdbind-tutorial-and-usage-details/





## References

[^1]:https://en.cppreference.com/w/cpp/language/lambda

[^2]:https://en.cppreference.com/w/cpp/thread
[^3]:https://en.cppreference.com/w/cpp/thread/call_once

[^4]:https://www.geeksforgeeks.org/lambda-expression-in-c/

[^5]:https://en.cppreference.com/w/cpp

[^6]:https://thispointer.com/stdbind-tutorial-and-usage-details/

