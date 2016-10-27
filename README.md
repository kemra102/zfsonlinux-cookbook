# zfsonlinux Cookbook
[![Build Status](https://travis-ci.org/kemra102/zfsonlinux-cookbook.svg?branch=master)](https://travis-ci.org/kemra102/zfsonlinux-cookbook)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Attributes](#attributes)
4. [Usage](#usage)
  * [zfsonlinux_zpool](#zfsonlinux_zpool)
  * [zfsonlinux_dataset](#zfsonlinux_dataset)
5. [Contributing](#contributing)
6. [License & Authors](#license-and-authors)

## Overview

This module manages the installation and configuration of [ZFS on Linux](http://zfsonlinux.org/).

## Requirements

* Chef 12.5+
* `yum` Cookbook.
* `yum-epel` Cookbook.

## Attributes

| Key                             | Type      | Description                                                                                                       | Default |
|:-------------------------------:|:---------:|:-----------------------------------------------------------------------------------------------------------------:|:-------:|
| `['zfsonlinux']['manage_repo']` | `Boolean` | Determines if Chef should manage the Yum repos for ZFS on Linux or not as well as the EPEL repo on DKMS installs. | `true`  |
| `['zfsonlinux']['repo']['el']['type']` | `String` | Determines if `dkms` or `kmod` kernel modules should be used. If you are using the stock Red Hat kernel `kmod` is recommended. The default is set to `dksm` as this will work on any system by default. | `dkms`  |
| `['zfsonlinux']['kmod']['modprobe']` | `Boolean` | Determines if when using the `kmod` installation method if the kernel module should be loaded by Chef or not. | `true` |

## Usage

This cookbook can:

* Optionally sets up the ZFS on Linux (and EPEL if using the `dkms` style install) repo.
* Installs dependencies is using the `dkms` style install.
* Installs the ZFS package.
* Can manage [zpools](#zfsonlinux_zpool).
* Can manage [datasets](#zfsonlinux_dataset).

A minimal default install (managed repos using `dkms`):

```ruby
include_recipe 'zfsonlinux::default'
```

Using the `kmod` style install:

```ruby
node.default['zfsonlinux']['repo']['el']['type'] = 'kmod'

include_recipe 'zfsonlinux::default'
```

### `zfsonlinux_zpool`

To create a `zpool`:

```ruby
zfsonlinux_zpool 'morpheus' do
  vdevs ['/dev/sdb', '/dev/sdc']
end
```

To destroy a `zpool`:

```ruby
zfsonlinux_zpool 'morpheus' do
  action :destroy
end
```

>NOTE: This resource currently only supports striped zpools.

### `zfsonlinux_dataset`

To create a dataset with default properties:

```ruby
zfsonlinux_dataset 'morpheus/nebuchadnezzar'
```

>NOTE: You should ensure the parent `zpool` exists before creating a dataset on it.

To create a dataset with non-default properties:

```ruby
zfsonlinux_dataset 'morpheus/nebuchadnezzar' do
  properties mountpoint: '/ship'
             compress: 'lz4'
end
```

To remove a dataset without children:

```ruby
zfsonlinux_dataset 'morpheus/nebuchadnezzar' do
  action :destroy
end
```

To remove a dataset with children:

```ruby
zfsonlinux_dataset 'morpheus/nebuchadnezzar' do
  remove_children true
  action :destroy
end
```

## Contributing

If you would like to contribute to this cookbook please follow these steps;

1. Fork the repository on Github.
2. Create a named feature branch (like `add_component_x`).
3. Write your change.
4. Write tests for your change (if applicable).
5. Write documentation for your change (if applicable).
6. Run the tests, ensuring they all pass.
7. Submit a Pull Request using GitHub.

## License and Authors

License: [BSD 2-Clause](https://tldrlegal.com/license/bsd-2-clause-license-\(freebsd\))

Authors:

  * [Danny Roberts](https://github.com/kemra102)
  * [All Contributors](https://github.com/kemra102/yumserver-cookbook/graphs/contributors)
