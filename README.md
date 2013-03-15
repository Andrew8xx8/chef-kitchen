# Waytag vagrant boxe

## Requirements

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)

## Installation

Clone the repository:

```bash
$ git clone https://github.com/akalyaev/vagrant-boxes
$ cd vagrant-boxes
```

And install gems and chef's necessary packages:

```bash
$ bundle install
$ bundle exec librarian-chef install
```

Choose the box and go to that directory:

```bash
$ cd boxes/workvm
```

Finally, you should be able to use:

```bash
$ vagrant up
```

## Troubleshooting

### OS

* [VirtualBox vboxdrv problem on Ubuntu 12.10](http://nikunjlahoti.com/2012/11/09/virtualbox-on-ubuntu-12-10/)

### Boxes

If cases, where there are some recipes, which depends on a newer chef, run `gem install chef --no-ri --no-rdoc` (may require sudo) to update it.

Example error:

```bash
[Fri, 11 Jan 2013 11:06:19 +0100] FATAL: Stacktrace dumped to /tmp/vagrant-chef-1/chef-stacktrace.out
[Fri, 11 Jan 2013 11:06:19 +0100] FATAL: NoMethodError: undefined method `default_action' for #<Class:0x7f0c909547c0>
```

If chef cannot find some package (e.g. `libssl-dev not found`), try to run `sudo apt-get update --fix-missing`
