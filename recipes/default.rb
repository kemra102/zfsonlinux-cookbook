include_recipe 'zfsonlinux::repo' if node['zfsonlinux']['manage_repo']

# Install dependencies if using DKMS
package 'kernel-devel' if node['zfsonlinux']['repo']['el']['type'] == 'dkms'

package 'zfs'

# If using 'kmod' optionally load the module
if node['zfsonlinux']['repo']['el']['type'] == 'kmod' && node['zfsonlinux']['kmod']['modprobe'] == true # rubocop:disable Metrics/LineLength
  execute 'modprobe_zfs' do
    command 'modprobe zfs'
    not_if 'lsmod | grep zfs'
    path [
      '/sbin',
      '/bin',
      '/usr/sbin',
      '/usr/bin'
    ]
  end
end
