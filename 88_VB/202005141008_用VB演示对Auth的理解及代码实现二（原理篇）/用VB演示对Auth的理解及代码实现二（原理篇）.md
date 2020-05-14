用VB演示对Auth的理解及代码实现二（原理篇）

副标题：勇士拿到钥匙才能开启宝箱



上文书说到大观园权限认证的问题，要是能用上 `Auth` 该多好。

那么具体如何下手...呃，那个入手呢？

咱们先研究一下 `Auth` 的大概原理。

上图：

图1



图画得还凑合吧，能看明白吗？

一句话，勇士只有拿到钥匙（扮演角色），才能用钥匙打开宝箱（权限）。

好，咱们来详细分析分析看啊。



首先，三张表，用户、角色和权限。

```sql
-- 用户表
CREATE TABLE "user"(
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL, 
  [password] VARCHAR NOT NULL, 
  [status] TINYINT NOT NULL DEFAULT 1);
```

```sql
-- 角色表
CREATE TABLE [role](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL);
```

```sql
-- 权限表
CREATE TABLE [permission](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL);
```



其次，两张表，用户和角色的中间表，以及角色和权限的中间表。

两张中间关系表把三张实物表连接了起来。

```sql
-- 用户和角色关系表
CREATE TABLE [user_role](
  [uid] INTEGER NOT NULL, 
  [rid] INTEGER NOT NULL);
```

```sql
-- 角色和权限关系表
CREATE TABLE [role_permission](
  [rid] INTEGER NOT NULL, 
  [pid] INTEGER NOT NULL);
```

拢共五张表，清晰不？



再次，勇士通过扮演某个角色，他就能拥有成为某个角色拥有的钥匙。

有点绕是吧，简单地说，就是什么样的角色就有什么样的钥匙，什么样的钥匙就能开什么样的宝箱。



最后，勇士拿着钥匙尝试打开宝箱，打得开就是有权限，打不开就没有权限。

勇士可以扮演很多角色，那么就会拥有很多钥匙。

他拿着这些钥匙去打开各种各样的宝箱，但不管用了哪一把打开了宝箱，都说明他有打开这个宝箱的权限，否则没有权限。









