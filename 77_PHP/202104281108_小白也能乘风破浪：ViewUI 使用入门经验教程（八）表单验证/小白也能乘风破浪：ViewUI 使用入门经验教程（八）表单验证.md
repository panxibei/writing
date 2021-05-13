小白也能乘风破浪：ViewUI 使用入门经验教程（八）表单校验

副标题：请你填写火星一日游申请表~

英文：getting-started-with-viewui-8

关键字：view ui,iview,form,validate,rules



人类初步实现登陆火星可能是在10年之后，也可能是20年、50年或者更久。

无论时间多久，相信人类总会有那么值得纪念的一天。

话说如果有那么一天，人类又是如何从地球出发登上火星的呢？

乘坐火箭？宇宙飞船？还是充满科幻的太空天梯？

但不管用何种方式，在这漫长的N年前的今天就已经有不少人翘首以盼，希望早日实现他们的梦想了。



虽然我们现在还去不了火星，甚至贫穷限制了我们如何实现太空旅行之类的想象力，但却并不耽误我们在已有的认知中做一些力所能及而有积极意义的准备工作。

比如，自己先设计一个简单的登录火星计划申请表。

它大概是这个样子的。

图01



用纸和笔很容易设计出这样一份表单，但是面对未来蜂拥而至的火星爱好者们，似乎还是使用电脑系统来实现比较好。

不过，狂热的火星爱好者们如果一时激动狂乱地乱输一气，那么肯定会给工作人员的收集统计工作带来不小的麻烦。

由此问题来了，表单项设计很容易做到，但是如何实现表单项的合法输入校验呢？



在此我们只简单地讨论如何用 `View UI` 来实现这样一份简单的申请表单。

`View UI` 已经有这方面的基本功能，但似乎还是要给它加工一下才能做得更好。

OK，让我们一一道来！



### 一、实现表单项数据校验的方法和要点

1、`Form` 标签必须同时实现 `:model` 绑定数据（比如： `formValidate` ），以及 `:rules` 绑定校验规则（比如：`ruleValidate` ）。

```
<Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
  ......
</Form>
```



2、数据及校验规则通常为 `json` 格式，就是用大括号包含起来，其中有多个具体的数据项。

比如下列代码中，`formValidate` 为数据， `ruleValidate` 为校验规则。 

其中具体的某项校验规则为数组形式，可同时设定多种校验规则，比如某项必须同时满足必填以及数字格式等。

```
<script>
  export default {
    data () {
      return {
        formValidate: {    // 数据
          name: '',
          ...
        },
        ruleValidate: {    // 校验规则
		  name: [
			{ required: true, message: '姓名不可为空', trigger: 'blur' },
			{ ... }
		  ],
		}
      }
    }
  }
</script>
```



3、回到 `Form` 表单组件，在具体的表单项 `FormItem` 标签中， `prop` 属性设定为某个数据项。

比如，将姓名表单项的 `prop` 属性设定为数据 `formValidate` 中的 `name` 数据项。

```
<Form>
	<FormItem label="Name" prop="name">
    	<Input v-model="formValidate.name"></Input>
	</FormItem>
</Form>
```



4、综上所述，完整示例代码。

```
<Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
	<FormItem label="Name" prop="name">
    	<Input v-model="formValidate.name"></Input>
	</FormItem>
<Form>

<script>
  export default {
    data () {
      return {
        formValidate: {    // 数据
          name: ''
        },
        ruleValidate: {    // 校验规则
		  name: [
			{ required: true, message: '姓名不可为空', trigger: 'blur' }
		  ],
		}
      }
    }
  }
</script>
```



### 二、各种不同的校验规则

我们都知道变量或数据库字段有各种不同的类型，比如大概地有字符型啊数字型等等。

而不同类型的变量或字段是不可以直接拿来使用和存储的，所以必须要事先想办法规范（或称为格式化）输入，以保证其内容符合变量或字段的正常使用。

当我们自己写程序的时候，可以在程序中标准化符合使用类型的代码变量，这个不是什么大问题。

但用户呢？

他们并不懂你什么类型，只要是键盘上有的都可以敲不是吗？

所以，程序中特别是用户输入端必须做好规范的内容输入工作，这就不得不说到校验规则。



简而言之，校验规则就是规范用户输入的那么一个隐性的程序设定。

自然这也是要用代码来实现的，只是每一种规则都不尽相同，需要我们分别对待。



通常校验规则的格式如下：

```
规则名称: [
  { required: true, type: 'string', message: '姓名不可为空', trigger: 'blur' }
],
```

规则关键字 `required` ，意为必填项；

`type` 为输入类型，默认为字符型 `string` ；

`message` 为校验失败后的提示内容；

`trigger` 为触发方式，其值 `blur` 是指失去焦点，即光标离开输入框时触发，而 `change` 表示输入有变更时就触发。



同一字段可以有一个或多个检验规则。

接下来我们举几个典型的例子吧。



##### 1、必填项规则

比如前面提到的姓名，这个肯定是要填写的，否则不知道你是谁，那其他信息写得再多也没有意义对吧。

这里用到了一个关键字 `required` ，意为必填项，取值 `true` 或 `false` 。

```
ruleValidate: {
  name: [
    { required: true, message: '姓名不可为空', trigger: 'blur' }
  ],
}
```

图02



##### 2、数字类型规则

当用户填写类似于电话号码这样的内容时，你肯定希望他们能自觉输入数字，因为很显然电话号码是一堆数字。

但是即使用户不想输入其他的字符，也有可能因为他们天天996而一时昏了头给你输了几个英文字母。

因此你可以按如下例子能帮他们一把就帮他们一把。

```
ruleValidate: {
  phonenumber: [
    {
      type: "number",
      message: "电话号码只能包含数字",
      trigger: "blur",
      transform: (value) => {
        return value || value === 0 ? Number(value) : ""; // 转为数字
      },
    },
  ],
}
```



从上面的代码中可以看出来，仅仅简单地将规则类型 `type` 设定为 `number` 是无法过滤非数字输入的。

图03



##### 3、日期时间类型规则

日期时间很明显不同于其他类型，它有它自身的格式规范和一定的取值范围。

在这里需要注意的是，有 `date` 类型，但并没有 `time` 类型，所以只好使用正则来补充了。

```
date: [
  { required: true, type: 'date', message: '请注意日期格式哦~', trigger: 'change' }
],
time: [
  { type: 'string',
    pattern: /^(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/,
    message: '请注意时间格式哦~',
    trigger: 'change'
  }
],
```

图04



##### 4、邮件类型规则

电子邮件有默认的规则类型 `email` ，可以直接拿来用，挺爽的。

```
ruleValidate: {
  mail: [
  	{ type: 'email', message: '邮箱地址格式有点儿怪怪的~', trigger: 'blur' }
  ],
}
```

图05



##### 5、URL类型规则

除电子邮件外还有一个可以直接拿来用的规则类型 `url` 。

不过在实际输入时似乎需要用户一定要输入 `url` 前缀，比如 `http(s)://` 等等之类的形式。

```
ruleValidate: {
  url: [
  	{ type: 'url', message: '个人主页请以 "http(s)://域名" 的形式填写吧~', trigger: 'blur' },
  ],
}
```

图06



##### 6、多选数组类型规则

比如勾选你喜欢的明星，规则限制你只能至少挑一个或最多挑三个。

这时就要用到类型 `array` ，同时设定最小值 `min` 等于1，最大值 `max` 等于3。

```
ruleValidate: {
	idol: [
		{ type: 'array', min: 1, message: '亲，最少选择一个~', trigger: 'change' },
		{ type: 'array', max: 3, message: '亲，最多选择三个~', trigger: 'change' }
	],
}
```

图07



##### 7、利用正则表达式自定义规则

在实际输入时总会有一些比较复杂的情况出现，通常就不会是如单纯的数字或日期那么简单了。

那么这个时候就可以利用正则表达式来实现比较复杂的输入规则校验。

以我们日常常见的身份证输入来说，身份证应该是除最后一位可能是X外其他都由数字15或17或18位数字组成。

只要将这些规则写成正则表达式，放到 `pattern` 关键字后面即可。

```
ruleValidate: {
  identity: [
	{
	  type: 'string',
	  pattern: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
	  message: "身份证号码只能包含15、17或18位数字，且最后一位可能为X~",
	  trigger: 'blur',
	},
  ],
}
```

图08



### 三、提交整体验证

前面各项校验都没问题，为了更加保险，最后提交时我们还需要来个整体验证。

在整体验证通过后，还可以写一些其他相关的代码，比如进一步计算等等，最后就可以完成提交动作了。



##### 1、首先在按钮上绑定方法

提交按钮绑定方法：`handleSubmit('formValidate')`

重置按钮绑定方法：`handleReset('formValidate')`

```
<Form>
  <FormItem>
    <Button type="primary" @click="handleSubmit('formValidate')">提交</Button>
    <Button @click="handleReset('formValidate')" style="margin-left: 8px">重置</Button>
  </FormItem>
</Form>
```



##### 2、其次在 `methods` 中设定方法来判定是否校验OK

这里要十分注意一点，`Form` 标签中的 `ref` 值一定要和方法参数保持一致。

比如本例的 `ref="formValidate"` 和方法 `handleSubmit('formValidate')` ，前者的值和后者的参数是一致的。

```
methods: {
  // 提交校验
  handleSubmit (name) {
	this.$refs[name].validate((valid) => {
	  if (valid) {
		this.$Message.success('不容易啊，校验成功了！');
		
		...... // 接着干点啥都行~
		
	  } else {
		this.$Message.error('怎么肥四？校验失败！');
	  }
	})
  },
  // 重置所有输入
  handleReset (name) {
	this.$refs[name].resetFields();
  }
}
```



### 最后收尾

以上即是我关于表单校验的一些粗略总结。

如果你使用过 `View UI` 这套组件，那应该知道其实它已经有很多丰富的输入型组件，比如文本框、日期框等等。

这些组件已经为我们很好地过滤了一些用户的不合理输入，但细化到更详细的规则要求，那么本文的表单校验就变得非常有意义了。

另外活用正则表达式，可以让你秒变超人，它给我的感觉就好像是万能的。

不过也要注意其校验规则的类型，它并不一定很作用，前文也有提到，要小心。

好了，就说这么多吧，说多了你也记不住，学习是个漫长的过程对吧，不要急于一时。

请小伙伴们有什么想说的，评论区走起，素质三连，谢谢啦！



**完整演示源码 test08.7z：**

下载链接：https://www.90pan.com/b2526985

提取码：p9g8



**扫码关注@网管小贾，阅读更多**

**网管小贾的博客 / www.sysadm.cc**