小白也能乘风破浪：ViewUI 使用入门经验教程（八）表单验证

副标题：

英文：

关键字：



人类初步实现登录火星可能是在50年之后，

人们如何登录上火星？

火箭？宇宙飞船，还是太空天梯？

但在这漫长的50年前的今天就已经有不少人翘首以盼了。

虽然我们现在还去不了火星，甚至贫穷限制了我们如何实现太空旅行之类的想象力，但却不耽误我们在已有的认知中做一些力所能及而有意义的准备工作。

比如做个简单的登录火星计划申请表。

它大概是这个样子的。

图1



用纸和笔很容易设计出这样一份表单，但是面对未来蜂拥而至的火星登录爱好者们，似乎还是使用电脑系统来实现比较好。

在此我们只简单地讨论如何用 `View UI` 来实现这样一份简单的申请表单。

那么问题来了，表单项设计很容易做到，但是如何实现表单项的合法输入验证呢？

`View UI` 已经有这方面的功能，让我们一一道来。



一、实现表单项数据验证的方法和要点

1、`Form` 标签必须同时实现 `:model` 绑定数据（比如： `formValidate` ），以及 `:rules` 绑定验证规则（比如：`ruleValidate` ）。

```
<Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
  ......
</Form>
```



2、数据及验证规则通常为 `json` 格式，就是用大括号包含起来，其中有多个具体的数据项。

比如下列代码中，`formValidate` 为数据， `ruleValidate` 为验证规则。 

```
<script>
  export default {
    data () {
      return {
        formValidate: {    // 数据
          name: ''
        },
        ruleValidate: {    // 验证规则
		  name: [
			{ required: true, message: '姓名不可为空', trigger: 'blur' }
		  ],
		}
      }
    }
  }
</script>
```



3、回到 `Form` 表单组件，在具体的表单项 `FormItem` 标签中， `prop` 属性设定为某个数据项。

比如，将姓名表单项的 `prop` 属性设定为 `formValidate` 中的 `name` 数据项。

```
<Form>
	<FormItem label="Name" prop="name">
    	<Input v-model="formValidate.name"></Input>
	</FormItem>
</Form>
```







2、`FormItem` 标签中 `prop` 属性设定为 `data` 中的数据项。



```
<Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
	<FormItem label="Name" prop="name">
    	<Input v-model="formValidate.name" placeholder="Enter your name"></Input>
	</FormItem>
<Form>
```

