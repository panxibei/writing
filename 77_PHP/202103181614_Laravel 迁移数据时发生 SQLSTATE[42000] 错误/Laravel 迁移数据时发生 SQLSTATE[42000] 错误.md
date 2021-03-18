Laravel 迁移数据时发生 SQLSTATE[42000] 错误

副标题：



`Laravel` 是一款优雅而强大的 `PHP` 框架，其中数据迁移功能很有用，并且经常被用于新构建的项目。

但是事事并非如人愿，即便是强大如 `Laravel` 也会动不动给你脸色看，数据迁移也经常会报个错让你难堪。

这不前几天我就遇到了一个错误，似乎以前也时有见过这家伙的身影。

> Laravel 6.x | MySQL 5.7

```
Illuminate\Datebase\QueryException : SQLSTATE[42000]: Syntax error or access violation: 1071 Specified key was too long; max key length is 1000 bytes (SQL: alter table `permissions` add unique `permissions_name_guard_name_unique`(`name`, `guard_anme`))
```

图1



像类似于这种的错误，以前倒是见过几面，隐约记得是 `MySQL` 的兼容问题，好像是什么字符数限制之类的。

光看错误的字面意思，应该是创建唯一索引时名称长度超过的限制。

事实真的是这样吗？

带着不解，我又麻木地打开了搜索工具。



网上最多的答案，便是在 `app\Providers\AppServiceProvider.php` 中追加一行代码。

```
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // 追加这么一行
        Schema::defaultStringLength(191);
    }
```

结果当然是不行，因为我文章还没写完，这个毛病肯定是个疑难杂症，没那么简单。



接下来又人说了，应该是 `config\database.php` 中配置问题。

应该将 `strict` 修改为 `false` 。

这个我倒是有点印象，但是试过了，仍然不行。



最后在 `Github` 上找到了答案，

```
'connections' => [
    ...

    'mysql' => [
        ...

        // 'engine' => null,
        'engine' => 'InnoDB ROW_FORMAT=DYNAMIC',

        ...
    ],
```

