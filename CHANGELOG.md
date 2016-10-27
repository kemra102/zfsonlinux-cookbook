## 2016-11-27 (v1.0.0)
### Summary

Initial release.

#### Features

- Optionally set-up ZFS on Linux repos (EL 6 & 7 supported.)
- Install ZFS package (`dkms` & `kmod` supported).
- Optionally enable the `zfs` kernel module.
- Custom resources for:
  - zpools (`zfsonlinux_zpool`) - striped zpools only at this time.
  - datasets (`zfsonlinux_dataset`)
