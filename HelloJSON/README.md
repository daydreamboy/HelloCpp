## Templated JSON

### 1、结构

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

结构分为4个部分，header、template、data和action部分，实现模板、数据、事件处理分离。template部分，是必须的；其他三部分，是可选的。

* header，用于存放meta信息，例如title、summary等
* template，用于定义模板，一般是UI布局
* data，用于定义数据，一般是style，map等
	* style，用于设置样式，类似CSS
	* map，用于定义key/value，填充template
* action，用于事件响应


### 2、语法

#### 1. ifelse语句

```
// if-elseif-else
"text": [
{ "#if <expression>": "<if clause>"},
{ "#elseif <expression>": "<elseif clause>"},
{ "#else": "<else clause>"},
]

// if-else
"text": [
{ "#if <expression>": "<if clause>"},
{ "#else": "<else clause>"},
]

```

设计说明：类似C的ifelse，考虑到if/elseif/else语句有一定的顺序，则采用数组结构，数组元素则是词典。

关键字：#if、#elseif、#else。

逻辑处理：对expression做布尔运算，如果true(非0)，则保留对应clause部分；如果false（0），则不保留对应clause部分，但至少有一个#else关键字，不然报错。

注意事项：关键字和expression至少有一个空格。expression中不允许有空格。

#### 2. each语句

```
{
	"#each <variable>": {
		"type": "label",
		"text": "$name"
	}
}
```

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

