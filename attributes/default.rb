default['zfsonlinux']['manage_repo'] = true

# Set to 'kmod' if you prefer to use the pre-built kernel modules
# kmod is advised if you are using the vanilla Red Hat kernel
default['zfsonlinux']['repo']['el']['type'] = 'dkms'
