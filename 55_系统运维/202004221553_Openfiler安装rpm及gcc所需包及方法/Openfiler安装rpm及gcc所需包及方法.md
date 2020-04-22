Openfiler安装rpm及gcc所需包及方法

副标题：我太难了



Openfiler安装rpm、gcc、yum，用于手动安装网卡驱动等自行定制程序。由于openfiler做了高度精简，rpm、gcc及yum都没有安装，而其自带的conary也已经失效。正好手头上的buffalo nas盘的网卡无法被正常识别，只好被迫走上自行解决的道路。



首先要解决rpm安装的问题。使用winscp上传rpm管理器包到openfiler。

使用openfiler自带的rpm2cpio解压rpm包，发现失败。

shell>rpm2cpio rpm-4.8.0-55.e16.x86_64.rpm | cpio -ivd

图1



使用7zip双击打开rpm包，经过多次双击后，最终可看到usr等子目录。

把这些目录解压到一个单独的文件夹内，然后上传到openfiler的根目录下。

图2



追加rpm的可执行属性。

shell>chmod a+x /bin/rpm

执行rpm，发现无法加载librpmbuild.so.1的错误。

图3



在163镜像源中找到相应的rpm包，使用7zip打开rpm包再多次双击的方法（同上），把多个目录上传到openfiler根目录下。

再次运行rpm，发现还有其他共享库文件未能加载。按照方法依次找到这些库文件包，解压上传即可。





再次运行rpm，提示库文件尺寸太小。

按提示依次删除0字节库文件，然后做实际库文件的链接。

shell>rm -f /usr/lib64/librpmbuild.so.1shell>ln -s /usr/lib64/librpmbuild.so.1.0.0 /usr/lib64/librpmbuild.so.1

图4



最后执行rpm即可正常使用安装rpm包。

（在第二部分将继续说明如何在openfiler下安装yum）

图5



待续。。。