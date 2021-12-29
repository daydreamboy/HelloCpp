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





## 2、using

（1）别名

C++11支持using用于别名

[1] https://stackoverflow.com/a/20791007



## 3、R语法

格式：prefix(optional) R "delimiter( raw_characters )delimiter"

[1] https://en.cppreference.com/w/cpp/language/string_literal

