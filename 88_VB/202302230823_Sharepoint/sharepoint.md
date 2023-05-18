sharepoint

副标题：

英文：

关键字：





`Get` 请求代码。

```vb
Set oHttpReq = CreateObject("MSXML2.ServerXMLHTTP")


strUrl = "https://127.0.0.1/vbhttp/http_get.php"
strData = "user=admin?password=123"
isAsync = False
index = 1

' 打开连接并构建连接到服务器的请求
If Len(strData) > 0 Then
	oHttpReq.Open "GET", strUrl & "?" & strData, isAsync
Else
	oHttpReq.Open "GET", strUrl, isAsync
End If

' 请求头，有特殊情况可再添加
'oHttpReq.setRequestHeader "Content-Type", "text/html; charset=UTF-8"
'oHttpReq.setRequestHeader "User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080406 K-MeleonCCFME/0.08"

' 发送讲求到服务器
oHttpReq.send

' 轮循等待响应'    
Do Until oHttpReq.ReadyState = 4
	DoEvents
Loop

' 按不同方式获取返回响应的内容
Select Case Index
Case 1: WebRequestGet = oHttpReq.responseText  '返回字符串
Case 2: WebRequestGet = oHttpReq.responseBody '返回二进制
Case 3: WebRequestGet = BytesToStr(oHttpReq.responseBody) '二进制转字符串[直接返回字串出现乱码时尝试]
Case Else: WebRequestGet = vbNullString '无效的返回
End Select

Set oHttpReq = Nothing
```

