case node['platform']
when 'centos'
  cookbook_file '/etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinx' do
    source 'gpg.key'
    notifies :run, 'execute[import-key]', :immediately
  end

  execute 'import-key' do
    command 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinx'
    not_if "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinx) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')"
  end

  yum_repository 'zfsonlinux' do
    description "ZFS on Linux for EL #{node['platform_version'].to_i}"
    baseurl case node['zfsonlinux']['repo']['el']['type']
            when 'dkms'
              "http://download.zfsonlinux.org/epel/#{node['platform_version'].to_i}/$basearch/"
            when 'kmod'
              "http://download.zfsonlinux.org/epel/#{node['platform_version'].to_i}/kmod/$basearch/"
            end
    enabled true
    gpgcheck true
    gpgkey 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinx'
  end

  include_recipe 'yum-epel::default' if node['zfsonlinux']['repo']['el']['type'] == 'dkms'
else
  Chef::Application.fatal!("#{node['platform']} #{node['platform_version']} is not supported.")
end
