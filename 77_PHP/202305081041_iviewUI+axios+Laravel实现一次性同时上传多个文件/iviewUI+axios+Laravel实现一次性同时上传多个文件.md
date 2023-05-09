iviewUI+axios+Laravel实现一次性同时上传多个文件

副标题：iviewUI+axios+Laravel实现一次性同时上传多个文件

英文：

关键字：



iviewUI+Laravel实现同时多文件上传



`iViewUI` 的上传组件 `Upload` 默认基本用法是一次选择一个文件。

然而有很多场景是需要一次选择多个文件上传的，当然 `iViewUI` 也是支持多个文件上传，只要加上 `multiple` 属性即可。

不过这个 `multiple` 属性并不是它的发明，因为 `Upload` 组件是基于原生的 `input` 标签，而 `input` 就是用的 `multple` 。

```
<input type="file" multiple>
```





环境配置及对应版本：

* `Vue.js` - `2.5.16`
* `iviewUI` - `4.5.x`
* `axios` - `0.18.0`
* `PHP` - `8.1`
* `Laravel` - `10.7.1`



前端写法：



上传组件：

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





变量定义

```vue
// 上传组件所需要的变量
full: null, // 文件对象变量
uploadList: [], // 获取上传文件列表
loadingStatus: false, // 上传状态
uploaddisabled: false, // 是否禁用上传
```





上传组件使用到的方法函数

```javascript
// 将上传文件存放到变量file中
handleUpload (file) {
    this.file = file;
    return false;
},

// 
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

uploadListRemove (index) {
    this.uploadList.splice(index, 1);
},
```





后端写法：



```php
/**
* 后端上传文件演示
*/
public function applicantImport(Request $request)
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

