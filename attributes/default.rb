default['zfsonlinux']['manage_repo'] = true

# Set to 'kmod' if you prefer to use the pre-built kernel modules
# kmod is advised if you are using the vanilla Red Hat kernel
default['zfsonlinux']['repo']['el']['type'] = 'dkms'

# When using 'kmod' module attempt to load it by default.
# Does not apply to 'dkms' kernels as they invariably require a reboot.
default['zfsonlinux']['kmod']['modprobe'] = true
