# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "debian-squeeze-64"
  config.vm.box_url = "http://dl.dropbox.com/u/937870/VMs/squeeze64.box"
  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  config.vm.network :hostonly, '192.168.3.13'

  config.vm.share_folder "Dropbox", "~/Dropbox", "~/Dropbox"
  config.vm.share_folder "projects", "~/projects", "~/projects"

  # see README.md for details
  workvm = {
    :user               => 'vagrant', # always use vagrant user
    :home               => '/home/vagrant',
    :fullname           => 'USERNAME',
    :email              => 'EMAIL',
  }

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./cookbooks", "./site-cookbooks"]

    chef.add_recipe "rvm::system"
    chef.add_recipe "rvm::user"

    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::ruby"

    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::ruby"

    chef.add_recipe "redisio::install"
    chef.add_recipe "redisio::enable"

    chef.add_recipe "rabbitmq"

    chef.add_recipe "janus"

    chef.add_recipe "workvm"

    chef.json = {
      :workvm => workvm,
      :rvm => {
        :user_installs => [{
          :user => workvm[:user],
          :default_ruby => '1.9.3-p327-railsexpress',
          :global_gems => [{ :name => 'bundler'}, { :name => 'rake' }],
          :gems => {
            '1.9.3-p327-railsexpress' => [
              { :name => 'chef' }
            ]
          },
          :rubies => [{
            'version' => '1.9.3-p327-railsexpress',
            'patch' => 'railsexpress',
          }]
        }]
      },
      :mysql => {
        :server_root_password => "",
        :server_repl_password => "",
        :server_debian_password => ""
      },
      :postgresql => {
        :password => {
          :postgres => "dLxRz0oyF7i3vuMMCoppyMMzOz3SLE"
        },
        :pg_hba => [
          {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'trust'},
          {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'trust'},
          {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
          {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}
        ]
      }
    }
  end
end
