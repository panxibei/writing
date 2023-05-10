iViewUI+Axios+Laravel实现一次性同时上传多个文件

副标题：iViewUI+Axios+Laravel实现一次性同时上传多个文件

英文：

关键字：





`iViewUI` 的上传组件 `Upload` 默认基本用法是一次选择一个文件。

然而有很多场景是需要一次选择多个文件上传的，当然 `iViewUI` 也是支持多个文件上传，只要加上 `multiple` 属性即可。

不过这个 `multiple` 属性并不是它的创造发明，因为 `Upload` 组件是基于原生的 `input` 标签，而 `input` 就是用的 `multple` ，因此只要简单地加上 `multiple` 属性就可以支持多文件上传了。



如下，原生的 `input` 标签就支持多文件同时浏览上传。

```
<input id="upload" type="file" multiple>
```



对于 `iViewUI` 也是一样的。

```html
<Upload
    multiple
    action="//sysadm.cc/posts/">
    <Button icon="ios-cloud-upload-outline">Upload files</Button>
</Upload>
```



好了，你可以试一下，原先只能选择单个文件，现在加了 `multiple` 属性后的确可以选择多个文件。

不过选择是可以选择了，只是它是如何触发上传这个动作的呢？

其实也挺简单的，加个 `onchange` 方法就行了。

```
<input id="upload" type="file" multiple onchange="uploadFile(value)">
```



如下 `uploadFile` 方法可以获取到待上传文件的信息，包括文件名和路径。

```js
<script>
    function uploadFile(value) {
        // 获取上传控件dom
        var upload = document.getElementById('upload');
        
        // 获取文件名
        var fileName = upload.files[0].name;
        
        // 获取文件完全路径
        var filePath = upload.value;
    }
</script>
```



我们可以通过 `upload.files` 来查看或操作文件信息。

图01



不过这只是原生 `input` 上传的用法，既然我们用到的 `iViewUI` ，那么用 `iViewUI` 又如何实现获取文件信息呢？



针对这个问题， `iViewUI` 的 `Upload` 组件就有一个名为 ` before-upload ` 的方法可以实现我们想要的功能。

在正式提交上传文件之前，这个方法会被触发，同时也会获取到文件信息。

但是吧，可能用过 `iViewUI` 的小伙伴会有体会，当我们选择并上传多个文件时，这个 `before-upload` 方法会单纯轮循多次，而不是一次性获取多个文件信息。

换句话说，就是你要同时上传两个文件，结果它却给你跑了两次，获取到的信息居然只有最后那个文件的！

这可怎么办呢？



我在网上查了很多相关资料，不是过时的就是无法真正地实现多文件上传功能。

后来经过研究测试，最后终于搞定了。

大体实现的方法是：

* 通过人为设定一个数组变量用于存放多文件信息
* 然后再通过 `before-upload` 方法，每获取到文件就放到数组变量中
* 最后就简单了，将文件信息添加到 `formData` 对象接口中，使用 `Axios` 提交即可。



环境配置及对应程序版本：

* `Vue.js` - `2.5.16`
* `iviewUI` - `4.5.x`
* `Axios` - `0.18.0`
* `PHP` - `8.1`
* `Laravel` - `10.7.1`



最终实现功能：

* 支持多个文件上传
* 可列出哪些等待上传的文件
* 可删除列表中待上传的文件
* 除文件上传外还可同步提交其他参数



上传文件效果图。

图02



部分演示代码。

图03

图04



完整代码我就不打包了，可在文章中直接查看。

**iViewUI+Axios+Laravel实现一次性同时上传多个文件完整源代码**

关注公众号，发送xxxxxx



注意，以下为付费内容。



### 前端写法

上传组件代码，支持多文件上传、文件格式过滤、实时列出上传文件等等功能。

```php+HTML
<Upload
    ref="upload"
    :before-upload="beforeupload"
    :show-upload-list="false"
    :format="['pdf']"
    :on-format-error="handleFormatError"
    :max-size="10240"
    multiple
    type="drag"
    action="/">
    <Icon type="ios-cloud-upload" size="32" style="color: #3399ff" :loading="loadingStatus" :disabled="uploaddisabled"></Icon>
    <p>选择文件上传</p>
</Upload>
<br>
<div v-for="(item, index) in uploadList">
    <span>@{{ item.name }}</span>
    &nbsp;<Icon type="ios-trash-outline" @click.native="uploadListRemove(index)"></Icon>
</div>
```



上传文件所需的变量定义。

```vue
// 上传组件所需要的变量
uploadList: [], // 获取上传文件列表
loadingStatus: false, // 上传状态
uploaddisabled: false, // 是否禁用上传
```



上传组件使用到的方法函数。

```javascript
// 上传前将文件存放到变量 uploadList 中
beforeupload (file) {
    this.uploadList.push(file); // 收集文件数量

    for(var i=0;i<this.uploadList.length;i++){
        if (this.uploadList.length>3) {
            this.uploadList.splice(this.uploadList.length-1, 1);
            this.error(false, '失败', '不能超过3个文件！');
            return false;
        }

        if (this.uploadList[i]['type'] == 'application/pdf') {
        } else {
            this.uploadList.splice(i, 1);
            this.error(false, '失败', '文档格式不正确！');
            return false;
        }
    }

    return false; // 仅收集文件列表，返回false，这个很重要
},

// 正提交上传文件
uploadstart () {
    this.uploaddisabled = true;
    this.loadingStatus = true;

    let formData = new FormData()

    for(var i=0;i<this.uploadList.length;i++){
        formData.append("file"+i,this.uploadList[i]);   // 依次添加文件对象到formData
    }

    formData.append("filenum", i); // 文件数量
    formData.append('foo', this.foo); // 其他一些参数


    var url = "http://foo.com/path";
    axios.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
    axios.defaults.headers.post['Content-Type'] = 'multipart/form-data';
    axios({
        url: url,
        method: 'post',
        data: formData,
        processData: false,// 告诉axios不要去处理发送的数据(重要参数)
        contentType: false, // 告诉axios不要去设置Content-Type请求头
    })
    .then(function (response) {
        if (response.data != 0) {
            this.success(false, '成功', '上传成功！');
        } else {
            this.error(false, '失败', '上传失败！');
        }

        setTimeout( function () {
            this.file = null;
            this.loadingStatus = false;
            this.uploaddisabled = false;
            this.uploadList = [];
            this.foo = '';
        }, 1000);
    })
    .catch(function (error) {
        this.error(false, 'Error', error);
        return false;
    })

},

// 删除指定的上传文件
uploadListRemove (index) {
    this.uploadList.splice(index, 1);
},
```



### 后端写法

在 `Laravel` 控制器中实现获取多文件信息，包括文件的原始名称、路径、扩展名等等。

以下代码将把多个文件按顺序依次存放到目录 `storage/public/当前日期/` 中。

```php
/**
* 后端上传文件演示
*/
public function getUploadFile(Request $request)
{
    if (! $request->isMethod('post') || ! $request->ajax()) return null;

    // 文件数量
    $filenum = $request->input('filenum');

	$fileCharater = [];

    for ($i=0; $i<$filenum; $i++) {
        array_push($fileCharater, $request->file('file'.$i));
    }

    for ($i=0; $i<$filenum; $i++) {
        if ($fileCharater[$i]->isValid()) {

            // 获取文件原始文件名（带扩展名）
            $clientoriginalname[$i] = $fileCharater[0]->getClientOriginalName();

            // 获取文件的扩展名 
            $ext = $fileCharater[$i]->extension();
            if ($ext != 'pdf') return 0;

            // 自定义文件名及路径，文件名最后保持两位数字
            // 例：2023年1月2日3点4分5秒第一个文件
            // 例：2023 01 02 03 04 05 00.xxx
            $filename[$i] = 'pdf' . date('YmdHis') . str_pad($i, 2, "0", STR_PAD_LEFT) . '.' .$ext;
            $filepath[$i] = 'public/'.date('Ymd');

            // 使用 storeAs 方法存储文件
            $fileCharater[$i]->storeAs($filepath[$i], $filename[$i]);

        } else {
            return 0;
        }
    }
}
```



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc