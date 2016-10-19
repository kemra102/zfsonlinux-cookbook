name 'zfsonlinux'
maintainer 'Danny Roberts'
maintainer_email 'danny@thefallenphoenix.net'
license 'BSD-2-Claue'
description 'Installs/Configures ZFS on Linux.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

source_url 'https://github.com/kemra102/zfsonlinux-cookbook' if respond_to?(:source_url) # rubocop:disable Metrics/LineLength
issues_url 'https://github.com/kemra102/zfsonlinux-cookbook/issues' if
  respond_to?(:issues_url)

depends 'yum', '>= 3.5.2'
depends 'yum-epel', '>= 0.7.0'
