# Kitchen

This is my solution to organize all my machines (local virtual machines,
remote virtual machines and servers)

* NO chef server required
* All machines managed by same commands

## Tools

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)
* [Chef (solo)](http://www.opscode.com/chef/) 
* [knife-solo](https://github.com/matschaffer/knife-solo) 

## Usage

### General

Install gems by:

```shell
bundle install
```

Install cookbooks from by berkschef:

```shell
berks install --path cookbooks
```

### Local VM (with Virualbox + Vagrant)

First install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
and [Vagranlt](http://downloads.vagrantup.com/) on your machine.

So, go to the VM directory and start vagrant:

```shell
cd v/default_ruby
vagrant up
```

Now Vm is runned. You can to stop it by `vagrant halt` command or
suspend/resume by `vagrant suspend`/`vagrant resume`

Copy your public key to VM (password is `vagrant`):

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.3.11
```

To bootstrap chef-solo on VM run this command:

```shell
cd ../../
knife solo bootstrap vagrant@192.168.3.11 nodes/default_ruby_vagrant.json
```

It's updates chef on VM6 uploads our kitchen and runs chef-solo.

In future you can run chef-solo by:

```shell
knife solo cook vagrant@192.168.3.11 nodes/default_ruby_vagrant.json
```

#### Sync folders via NFS

If you get error such like this when you trying to use NFS: 

```
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

mount -o vers=3 192.168.3.1:'~/projects'
/home/vagrant/projects
```

May be you need to update your Virtualbox Guest Additions in 
VM. You can install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest). 
This plugin updates Guest Additions automaticly. 

If after updating Guest Additions you need to reload VM:

```shell
vagrant reload
```

### Remote machine

Copy your public key to machine:

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub root@YOUR_IP_ADRESS
```

Bootstrap chef-solo on VM from root of kitchen:

```shell
knife solo bootstrap root@YOUR_IP_ADRESS nodes/default_ruby.json
```

In future you can run chef-solo by:

```shell
knife solo cook root@YOUR_IP_ADRESS nodes/default_ruby.json
```

## Kitchen description
