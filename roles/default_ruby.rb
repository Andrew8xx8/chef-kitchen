#encoding: utf-8
name "default_ruby"
description "Default ruby Machine"

run_list [
  "recipe[rvm::system]",
  #"recipe[locale]",
  #"recipe[nginx]",

  #"recipe[postgresql::server]",
  #"recipe[postgresql::ruby]",

  #"recipe[mysql::server]",
  #"recipe[mysql::ruby]",

  #"recipe[redisio::install]",
  #"recipe[redisio::enable]",

  #"recipe[workvm]"
]

default_attributes(
  # [pgsql::server]
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
  },
  :workvm => {
    :user               => 'vagrant', # always use vagrant user
    :home               => '/home/vagrant',
    :fullname           => 'Andrew Kulakov',
    :email              => 'avk@8xx8.ru'
  },
  rvm: {
    default_attributes: '1.9.3-railsexpress',
    rubies: [
      {
        'version' => '1.9.3-railsexpress',
        'patch' => 'railsexpress',
      },
      '2.0.0'
    ],
    global_gems: [
      { name: 'bundler'}
    ]
  },
  :mysql => {
    :server_root_password => "",
    :server_repl_password => "",
    :server_debian_password => ""
  }
)
