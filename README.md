# C++语法手册

[TOC]

## 1、std::string

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



### (1) String IO

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

TODO



#### b. `=`按值拷贝捕获

TODO



#### c. 指定变量捕获

TODO



如果没有变量捕获，则capture列表可以为空。

举个例子，如下

```c++
auto square = [](int i)
{
    return i * i;
};

std::cout << "Square of 5 is : " << square(5) << std::endl;
```





## 3、algorithm库

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





## 3、using

（1）别名

C++11支持using用于别名

[1] https://stackoverflow.com/a/20791007



## 4、R语法

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



## References

[^1]:https://en.cppreference.com/w/cpp/language/lambda

