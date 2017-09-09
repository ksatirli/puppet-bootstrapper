# Puppet 3.x Bootstrapper

> Deploy and configure [Puppet](https://puppet.com) on your server with a single line of code.

## This project is no longer maintained

The _Puppet Bootstrapper_ is no longer actively maintained and is only made available here for reference. The project itself is still capable of installing a Puppet `3.x` setup on `yum`-based systems and has rudimentary support for Debian and Ubuntu.

What follows is the original `README.md`:

---

## Table of Contents

- [Requirements](#requirements)
- [Dependencies](#dependencies)
- [History](#history)
- [Usage](#usage)
- [Author Information](#author-information)
- [License](#license)

## Requirements

A `yum`-based OS such as RHEL, CentOS or Amazon Linux.

## Dependencies

This script has no external dependencies.

## History

### Start with the latest version of Puppet

Ignite your deployment by starting out with the latest and greatest version of Puppet, Hiera and all the other tools you have come to love. No more fighting your way through multiple packages, GPG keys and architectures but a simple, all-in-one solution for your deployment.

### Tap into your Git repository

Sync your version-controlled manifests with your server - including submodules and external dependencies.

Not using Git? No problem! We support Subversion just as well and are actively working on Mercurial support.

### Automatically updated manifests are here

Getting all your Puppet files locally is just the first step: _Puppet Bootstrapper_ will keep checking in with the mothership to get all the latest changes, at regular intervals, and will apply them instantly.

All the magic can easily be turned off, if you want to sit in the captain's chair every now and then.

## Usage

Install _Puppet Bootstrapper_ by copying and pasting the line below on a fresh server - no matter if it is RHEL, CentOS or Amazon's Linux AMI - we've got you covered. Debian or Ubuntu lover? We're working on making you happy, too!

### Standard mode

Fast-travel to deployment: hardly any debug information on your screen. You like it clean.

All information will still be logged to the `puppet-bootstrapper.log` file.

```
sh -c "$(curl -s https://raw.githubusercontent.com/withmethod/puppet-bootstrapper/master/build)"
```

### Debug mode

You're in for the long haul: this route will show you all the steps as they are carried out.

All information will be shown on your screen and logged to the `puppet-bootstrapper.log` file.

```
sh -c "$(curl -s https://raw.githubusercontent.com/withmethod/puppet-bootstrapper/master/build)" -- -v
```

### Fully-automated mode

Deploy without having to log in to your server by specifying the `BOOTSTRAP_REPO` environment variable and your repository will automatically be configured. Perfect for setups with access to `cloud-init` and similar tools.

All information will be logged to the `puppet-bootstrapper.log` file.

```
export BOOTSTRAP_REPO="https://github.com/yourorg/puppet.git"; sh -c "$(curl -s https://raw.githubusercontent.com/withmethod/puppet-bootstrapper/master/build)"
```

## Author Information

This repository was maintained by the individuals listed below.

- [Kerim Satirli](https://github.com/ksatirli)

## License

Copyright 2013-2017 [Kerim Satirli](https://github.com/ksatirli)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
