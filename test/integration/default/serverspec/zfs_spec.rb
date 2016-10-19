require 'serverspec'

set :backend, :exec

describe file('/etc/yum.repos.d/zfsonlinux.repo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match %r{^baseurl=http:\/\/download\.zfsonlinux\.org\/epel\/(6|7)\/\$basearch\/$} } # rubocop:disable Metrics/LineLength
end

%w(kernel-devel zfs).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
