用VB演示对Auth的理解及代码实现一（引言篇）

副标题：项目中绕不开的权限问题





1、创建用户表（user）

```sql
CREATE TABLE "user"(
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL, 
  [password] VARCHAR NOT NULL, 
  [status] TINYINT NOT NULL DEFAULT 1);
```



2、创建用户组表（group）

```sql
CREATE TABLE [group](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL, 
  [rules] VARCHAR NOT NULL, 
  [status] TINYINT NOT NULL DEFAULT 1);
```



3、创建规则表（rule）

```sql
CREATE TABLE [rule](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL, 
  [status] TINYINT NOT NULL DEFAULT 1);
```



4、创建用户组与规则关系表（group_access）

```sql
CREATE TABLE [group_access](
  [uid] INTEGER NOT NULL, 
  [gid] INTEGER NOT NULL);
```



