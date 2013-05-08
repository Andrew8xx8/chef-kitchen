#encoding: utf-8
name "default_ruby_vagrant"
description "Default ruby machine for vagrant"

run_list [
  "recipe[rvm::user_install]",
  "recipe[locale]",
  "recipe[nginx]",

  "recipe[postgresql::server]",
  "recipe[postgresql::ruby]",

  "recipe[mysql::server]",
  "recipe[mysql::ruby]",

  "recipe[redisio::install]",
  "recipe[redisio::enable]",
]

default_attributes(
  rvm: {
    user_installs: [{
      default_attributes: '1.9.3-railsexpress',
      user: "vagrant",
      rubies: [
        {
          version: '1.9.3-railsexpress',
          patch: 'railsexpress'
        },
      ],
      global_gems: [
        { name: 'bundler'}
      ]
    }],
    global_gems: [
      { name: "chef" }
    ]
  },
  mysql: {
    server_root_password: "my_secure_password",
    server_repl_password: "my_secure_password",
    server_debian_password: "my_secure_password"
  }
)

override_attributes(
  postgresql: {
    password: {
      postgres: "my_secure_password"
    },
    pg_hba: [
      {type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'trust'},
      {type: 'local', db: 'all', user: 'all', addr: nil, method: 'trust'},
      {type: 'host',  db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'trust'},
      {type: 'host',  db: 'all', user: 'all', addr: '::1/128', method: 'trust'}
    ]
  }
)
