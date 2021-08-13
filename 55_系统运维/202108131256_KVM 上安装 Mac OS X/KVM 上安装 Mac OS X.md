

标题：

副标题：

英文：

关键字：







> https://github.com/kholia/OSX-KVM

官网上虽然有安装方法，但是有点笼统又显得不太灵活，对我等小白也不太友善。

我研究了好几天，终于研究出来可以自己想怎么安装就怎么安装的方法。



坑：

GLib-WARNING **: gmem.c:489: custom memory allocation vtable not supported

> https://bugzilla.redhat.com/show_bug.cgi?id=1666811



```
# 将 `/usr/libexec/qemu-system-x86_64`
<emulator>/usr/libexec/qemu-system-x86_64</emulator>

# 替换成 `/usr/bin/qemu-kvm`
<emulator>/usr/bin/qemu-kvm</emulator>
```

有人说这不是一样的嘛，起初我也是这么想的，别想到我替换后问题居然解决了！

图k01





注意修改以下标记内容。

```
  <name>macOS</name>
  <uuid>2aca0dd6-cec9-4717-9ab2-0b7b13d111c3</uuid>
  <title>macOS</title>
```



磁盘启动关键点，通过 `BaseSystem.img` 启动并加载 `OpenCore.qcow2` ，这两者缺一不可。

```
    <disk type="file" device="disk">
      <driver name="qemu" type="qcow2" cache="writeback" io="threads"/>
      <source file="/your_path_for_osx/OSX-KVM/OpenCore-Catalina/OpenCore.qcow2"/>
      <target dev="sda" bus="sata"/>
      <boot order="2"/>
      <address type="drive" controller="0" bus="0" target="0" unit="0"/>
    </disk>
    <disk type="file" device="disk">
      <driver name="qemu" type="raw" cache="writeback" io="threads"/>
      <source file="/your_path_for_macos_img/macOS.img"/>
      <target dev="sdb" bus="sata"/>
      <boot order="3"/>
      <address type="drive" controller="0" bus="0" target="0" unit="1"/>
    </disk>
    <disk type="file" device="disk">
      <driver name="qemu" type="raw" cache="writeback"/>
      <source file="/your_path_for_osx/OSX-KVM/BaseSystem.img"/>
      <target dev="sdc" bus="sata"/>
      <boot order="1"/>
      <address type="drive" controller="0" bus="0" target="0" unit="2"/>
    </disk>
```

