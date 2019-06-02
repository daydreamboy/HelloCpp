## Templated JSON Spec

### 1、JSON结构

```
{
    "header": {
        "title": "titile",
        "summary": ""
    },
    "template": {
        "id": 20014,
        "data": {
            "body": {}
        }
    },
    "data": {
    	"style": {}
    	"map": {}
    },
    "action": {
    }
}
```

JSON结构分为4个部分：header、template、data和action部分，分别对应头部、模板、数据、事件。template部分，是必须的；其他三部分，是可选的。

* header，用于存放meta信息，例如title、summary等
* template，用于定义模板，一般是UI布局
* data，用于定义template中用到的数据。子字段有style，map等
	* style，用于设置样式，类似CSS
	* map，用于定义key/value，用于template中变量
* action，用于事件响应

### 2、语法

#### 1. 表达式和变量

```json
"${text}": {
    "${number}": "${value + 2}"
}
```

任何需要使用变量和表达式的地方，必须使用${}，但是语法节点中可以不用使用，直接使用变量名即可。

$gobal是全局变量，而${gobal}是局部变量，$GLOBAL则是内置的全局变量。



#### 2. 条件语句



语法结构：

```json
// if-elseif-else节点
"text": [
	{ "${#if(<expression>)}": <json> },
	{ "${#elseif(<expression>)}": <json> },
	{ "${#else}": <json> }
]

// if-else节点
"text": [
	{ "#if <expression>": <json> },
	{ "#else": <json> }
]

// if节点
"text": [{ 
     "#if <expression>": <json> 
}]
```

设计说明：类似C的ifelse，考虑到if/elseif/else语句有一定的顺序，则采用数组结构，数组元素则是key(if/elseif/else)-value词典。

节点结构：词典组成的数组，词典个数为1到3个。

关键字：`#if`、`#elseif`、`#else`。

逻辑处理：对expression做布尔运算，如果true(非0)，则保留对应clause部分；如果false（0），则不保留对应clause部分，但至少有一个#else关键字，不然报错。

注意事项：关键字和expression至少有一个空格。expression中不允许有空格。

#### 3. foreach语句

```json
// 
"<array_variable>": [
    "label": "test1",
    "name": ""
]

// foreach节点
"text": [{
	"#foreach <iterator/#index> #in <array_variable>": <json>
}]

// Example 1
"text": [{
	"#foreach #index #in 1..3": <json>
}]
// 展开后
"text": [
    <json>,
    <json>
]

// Example 2
"text": [{
	"#foreach #index #in $1...$3": <json>
}]
// 展开后
"text": [
    <json>,
    <json>,
    <json>
]
    
// Example 3
"text": [{
    "#foreach element #in <array_variable>": ["{$element}", "{$element + 1}"]
}]

// Example 4
"text": [{
    "#foreach element #in <array_variable>": [{"key1": "{$element}"}, {"key2": "{$element + 1}"}]
}]
```

设计说明：考虑到解开循环之后，有一定顺序，也采用数组结构，数组元素则是key-value词典。

节点结构：词典组成的数组，词典个数仅为1。

关键字：`#each`、`#in`、`#index`

逻辑处理：对expression做布尔运算，如果true(非0)，则保留对应clause部分；如果false（0），则不保留对应clause部分，但至少有一个#else关键字，不然报错。

注意事项：如果需要下标索引，则使用#index，默认从0开始到数组个数-1。



#### 3. 语句嵌套

从外到内进行展开，直到每个节点中没有关键词



JSON Template

https://samcogan.com/dynamic-arm-templates-with-inline-logic-operators/



## nlohmann json手册

### 1. 类型判断

```
// is_number()
// is_number_float();
// is_number_integer()
// is_number_unsigned()
// is_number_float()
// is_object()
// is_array()
// is_string()
// is_boolean()
// is_discarded() // for callback function
    
// is_structured() == is_array() or is_object()
// is_primitive() == is_null() or is_string() or is_boolean() or is_number()
```

