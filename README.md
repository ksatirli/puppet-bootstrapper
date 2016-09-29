![Puppet Bootstrapper](https://cultivatedops-static.s3.amazonaws.com/projects/puppet-bootstrapper/logo-50.png)

> Deploy and configure Puppet on your server with a single line of code.

---

## Start with the latest version of Puppet.

Ignite your deployment by starting out with the latest and greatest version of Puppet, Hiera and all the other tools you have come to love. No more fighting your way through multiple packages, GPG keys and architectures but a simple, all-in-one solution for your deployment.

## Tap into your Git repository.

Sync your version-controlled manifests with your server - including submodules and external dependencies.

Not using Git? No problem! We support Subversion just as well and are actively working on Mercurial support.

## Automatically updated manifests are here.

Getting all your Puppet files locally is just the first step: _Puppet Bootstrapper_ will keep checking in with the mothership to get all the latest changes, at regular intervals, and will apply them instantly.

All the magic can easily be disabled, if you want to sit in the captain's chair every now and then.

## Requirements

* A `yum`-based OS such as RHEL, CentOS or Amazon Linux.

## Usage

Install _Puppet Bootstrapper_ by copying and pasting the line below on a fresh server - no matter if it is RHEL, CentOS or Amazon's Linux AMI - we've got you covered. Debian or Ubuntu lover? We're working on making you happy, too!

### Standard mode

Fast-travel to deployment: hardly any debug information on your screen. You like it clean.

All information will still be logged to the `puppet-bootstrapper.log` file.

```
sh -c "$(curl -s https://bitbucket.org/cultivatedops/puppet-bootstrapper/raw/HEAD/build)"
```

### Debug mode

You're in for the long haul: this route will show you all the steps as they are carried out.

All information will be shown on your screen and logged to the `puppet-bootstrapper.log` file.

```
sh -c "$(curl -s https://bitbucket.org/cultivatedops/puppet-bootstrapper/raw/HEAD/build)" -- -v
```

### Fully-automated mode

Deploy without having to log in to your server by specifying the `BOOTSTRAP_REPO` environment variable and your repository will automatically be configured. Perfect for setups with access to `cloud-init` and similar tools.

All information will be logged to the `puppet-bootstrapper.log` file.

```
export BOOTSTRAP_REPO="https://user:pass@bitbucket.org/yourorg/puppet.git"; sh -c "$(curl -s https://bitbucket.org/cultivatedops/puppet-bootstrapper/raw/HEAD/build)"
```

### Maintainers

This image was maintained by the individuals listed below.

* [Kerim Satirli](mailto:kerim@cultivatedops.com)

Active development seized in Summer 2015.

### License

`puppet-bootstrapper` is licensed under the _Apache 2.0_ license. A full copy of the license can be found on the [apache.org](http://www.apache.org/licenses/LICENSE-2.0) site.

In short, this license permits you to use this product commercially, distribute this software and make modifications.

The software is provided without warranty and any contributors cannot be held liable for damages. You are also not allowed to use any name, logo or trademark without prior consent.
