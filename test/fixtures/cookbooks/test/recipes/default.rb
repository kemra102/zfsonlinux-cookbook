node.default['zfsonlinux']['repo']['el']['type'] = 'kmod'

include_recipe 'zfsonlinux::default'

package 'util-linux-ng' if node['platform_version'].to_i == 6

execute 'fallocate' do
  command 'fallocate -l 4G /zfs'
  path ['/bin', '/usr/bin']
  not_if { ::File.exist?('/zfs') }
end

zfsonlinux_zpool 'morpheus' do
  vdevs ['/zfs']
end
