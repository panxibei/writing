iView实现table组件单元格行合并

副标题：程序员要有“自己动手，丰衣足食”的精神~



如今基于 `Vue.js` 的前端开源UI框架百花齐放、数不胜数，众多作品中不乏优秀者。

不知道小伙伴们有没有听说过 `iView` 这个前端框架，它是国内优秀团队开发的一套基于 `Vue.js` 的高质量UI组件库。

它比较适用于企业系统场景，我用得比较多，所以对它也一些浅薄的了解。

可以说，`iView` 这套组件库是非常强大的，应用于各种基本的使用场景都没问题，表现令人满意。

不过（我就知道你要来个转折），在使用 `table` 组件时，虽然它已经支持了表头分组的功能，但它却不支持单元格的行合并功能。

啥意思？

翻译成人话就是，我想要**一行内容后面分别对应多行内容**。

比如像这个样子：

图1



呃，这里要插播一下，现在最新版框架已经更名为 `View UI` ，版本号是 `4.x` 。

`4.x` 版本的框架已经支持行/列合并功能了，而我用的还是 `3.x` 版本的 `iView` 。

所以说，如果你有项目用的是 `3.x` 的，但出于某些原因暂时无法升级到 `4.x` 的话，那么就可以参考看看我现在写的内容啦。



好，插播完毕，正式开始！

通过强大的互联网收集整理了一些方法，基本原理是通过 `iView` 的 `render` 函数结合CSS样式渲染来实现目的。

为了方便理解，以下参考代码做了一些精简，**完整代码可到文末免费下载**。



CSS样式参考：

```css
/* table单元格行合并样式 */
.subCol>ul>li{
      margin:0 -18px;
      list-style:none;
      text-Align: center;
      padding: 9px;
      border-bottom:1px solid #E8EAEC;
      overflow-x: hidden;
	  line-height: 2.2;
}
.subCol>ul>li:last-child{
  border-bottom: none
}
```



HTML代码参考：

```html
<i-table ref="table1" height="360" size="small" border :columns="tablecolumns1" :data="tabledata1"></i-table>
```



JSON数据参考：

```json
// json数据
tabledata1: [
    {
        jieyueshuji: '西游记',
        jieyuexinxi: [
            {jieyuezhe: '刘备', jieyueriqi: '公元198年'},
            {jieyuezhe: '关羽', jieyueriqi: '公元199年'},
            {jieyuezhe: '张飞', jieyueriqi: '公元200年'},
        ]
    },
    {
        jieyueshuji: '三国演义',
        jieyuexinxi: [
            {jieyuezhe: '孙悟空', jieyueriqi: '公元2019年'},
            {jieyuezhe: '猪八戒', jieyueriqi: '公元2020年'},
        ]
    },
],
```



重点部分，JS代码参考：

```js
// 表头
tablecolumns1: [
    {
        type: 'selection',
        width: 60,
        align: 'center',
        fixed: 'left'
    },
    {
        title: '借阅书箱',
        key: 'jieyueshuji',
        align: 'center',
        width: 160,
    },
    {
        title: '借阅信息',
        align: 'center',
        children: [
            {
                title: '编号',
                key: 'jieyuexinxi',
                align:'center',
                width: 50,
                className: 'table-info-column-jieyuexinxi',
                render: (h, params) => {
                    return h('div', {
                        attrs: {
                            class:'subCol'
                        },
                    }, [
                        h('ul', params.row.jieyuexinxi.map((item, index) => {
                            return h('li', {
                            }, ++index)
                        }))
                    ]);
                }
            },
            {
                title: '借阅者',
                key: 'jieyuexinxi',
                align:'center',
                width: 160,
                className: 'table-info-column-jieyuexinxi',
                render: (h, params) => {
                    return h('div', {
                        attrs: {
                            class:'subCol'
                        },
                    }, [
                        h('ul', params.row.jieyuexinxi.map(item => {
                            return h('li', {
                            }, item.jieyuezhe)
                        }))
                    ]);
                }
            },
            {
                title: '借阅日期',
                key: 'jieyuexinxi',
                align:'center',
                width: 160,
                className: 'table-info-column-jieyuexinxi',
                render: (h, params) => {
                    return h('div', {
                        attrs: {
                            class:'subCol'
                        },
                    }, [
                        h('ul', params.row.jieyuexinxi.map(item => {
                            return h('li', {
                            }, item.jieyueriqi)
                        }))
                    ]);
                }
            },
        ]
    },
],
```



最终效果图：

图2



完整演示代码还包含操作等代码演示。

**关注微信公众号 @网管小贾，免费下载完整演示代码哦！**

下载链接：



> WeChat@网管小贾
>
> Blog@www.sysadm.cc



