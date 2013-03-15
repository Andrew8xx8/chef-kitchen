include_recipe "apt" # apt should be run first

node['workvm']['packages'].each do |pkg|
  package pkg
  package 'htop'
end

%w{ zsh }.each do |requirement|
  include_recipe requirement
end

git "#{node[:workvm][:home]}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  action :checkout
  not_if "test -d #{node[:workvm][:home]}/.oh-my-zsh"
end

directory "#{node[:workvm][:home]}/.oh-my-zsh" do
  owner node[:workvm][:user]
  group node[:workvm][:user]
  # mode 0644
  recursive true
end

template "#{node[:workvm][:home]}/.zshrc" do
  owner node[:workvm][:user]
  group node[:workvm][:user]
  mode 0644
  source "zshrc.erb"
  variables( :theme => node[:ohmyzsh][:theme] )
  action :create
end

template "#{node[:workvm][:home]}/.gitconfig" do
  owner node[:workvm][:user]
  group node[:workvm][:user]
  mode 0644
  source "gitconfig.erb"
  variables( :user => node[:workvm] )
  action :create
end
