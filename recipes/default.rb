include_recipe 'zfsonlinux::repo' if node['zfsonlinux']['manage_repo']

# Install dependencies if using DKMS
package 'kernel-devel' if node['zfsonlinux']['repo']['el']['type'] == 'dkms'

package 'zfs'
