Laravel 迁移数据时发生 SQLSTATE[42000] 错误

laravel-sqlstate-42000-error-occurred-while-migrating-data

副标题：又是 MySQL 的锅？



`Laravel` 是一款强大而优雅的 `PHP` 框架，其中数据迁移功能非常便利，经常被用于构建新项目。

但是事事并非如人愿，即便是强大如 `Laravel` 也会动不动给你脸色看，数据迁移时也经常会报个错让你难堪。

这不前几天我就遇到了一个错误，似乎以前也时有见过这家伙的身影。



> 系统环境：Laravel 6.x | MySQL 5.7
>
> 迁移数据：2021_03_13_144411_create_permission_tables



所要迁移的数据表是一张普通的权限表，这张表本身没有任何问题，是官方上下载并未作任何改动。

但数据迁移时却报如下错误。

```
Illuminate\Datebase\QueryException : SQLSTATE[42000]: Syntax error or access violation: 1071 Specified key was too long; max key length is 1000 bytes (SQL: alter table `permissions` add unique `permissions_name_guard_name_unique`(`name`, `guard_anme`))
```

图1



像类似于这种的错误，以前倒是见过几面，隐约记得是 `MySQL` 的兼容问题，好像是什么字符数限制之类的。

光看错误的字面意思，应该是创建唯一索引时名称长度超过了限制。

事实真的是这样吗？

带着不解，我又开始动作机械地打开了搜索工具。



网上最多的答案，便是在 `app\Providers\AppServiceProvider.php` 中追加如下一行代码。

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

结果当然是不行，因为我之前就已经追加了这么一行代码，很显然它没有起到作用。

眼前的这个毛病肯定是个疑难杂症，看样子没那么简单啊！



接下来又有小伙伴说了，应该是 `config\database.php` 中的配置问题。

应该将 `strict` 修改为 `false` 。

这个我也是有点印象的，但是同样我也试过了，仍然不行。



最后在 `Github` 上找到了答案，如下同样在 `config\database.php` 中， `mysql` 子项中，将数据库引擎变更为记录行格式是 `DYNAMIC` 。

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

图2



设定好后，还需要重新清除缓存和配置。

```
php artisan cache:clear
php artisan config:clear
```



最后再来迁移数据就没有问题了。

图3



查看数据库中也正确建立了相应的索引。

关于此问题，我特意搜索了关于记录行格式的相关解释，囫囵吞枣式的浏览看得我云里雾里。

`MySQL` 的确方便好用有一定的优势，但它同样也有这样那样的问题。

我用的是 `MySQL 5.7` ，不知道 `8.x` 会不会有此相同问题。

另外今后打算转战 `MariaDB` ，作为小白的我很想知道 `MariaDB` 也会存在类似的问题吗？

请小伙伴们有懂行的不吝赐教，评论区里顺手一键三连哈！



**关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc