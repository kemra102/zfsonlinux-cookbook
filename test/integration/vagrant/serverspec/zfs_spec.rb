require 'serverspec'

set :backend, :exec

describe file('/etc/yum.repos.d/zfsonlinux.repo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match %r{^baseurl=http:\/\/download\.zfsonlinux\.org\/epel\/(6|7)\/kmod\/\$basearch\/$} } # rubocop:disable Metrics/LineLength
end

describe package('zfs') do
  it { should be_installed }
end

# Test zpool resource
describe zfs('morpheus') do
  it { should exist }
end

# Test dataset resource
describe command('zfs list morpheus/nebuchadnezzar') do
  its(:exit_status) { should eq 0 }
end
