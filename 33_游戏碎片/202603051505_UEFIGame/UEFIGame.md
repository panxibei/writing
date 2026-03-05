UEFIGame

副标题：

英文：

关键字：







复制 `EFI` 程序和一些必要文件。

比如 `InsultSwordFighting.efi` 程序，那么它需要 `phrases.txt` 文件。

但是请注意，这两者不是放在一起的，看下面。

```
# Copy the application
cp InsultSwordFighting.efi uefi_disk/EFI/Boot/BOOTX64.efi

# Optional: Copy phrases file (must be UTF-16)
cp phrases.txt uefi_disk/EFI/UEFIGame/
```











```shell
qemu-system-x86_64 -drive if=pflash,format=raw,readonly=on,file=C:/UEFIGame/RELEASEX64_OVMF.fd -drive file=fat:rw:C:/UEFIGame,format=raw,if=virtio -cpu qemu64,+rdrand
```

