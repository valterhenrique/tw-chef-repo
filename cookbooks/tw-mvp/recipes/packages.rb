#
# Cookbook:: tw-mvp
# Recipe:: packages
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Follow instruction at https://leiningen.org/ or add ppa

remote_file '/bin/lein' do
  source 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if {File.exist?('/bin/lein')}
  notifies :run, 'execute[leiningen]', :immediately
end

execute 'leiningen' do
  command '/bin/lein'
  action :nothing
end

group 'mvp'
user 'mvp' do
  comment 'MVP application user'
  group 'mvp'
  system true
  shell '/bin/false'
  home '/opt/mvp'
  manage_home true
end

directory node['mvp']['home'] do
  owner 'mvp'
  group 'mvp'
  mode '2755'
end

git node['mvp']['home'] do
  repository node['mvp']['repository']
  revision 'master'
  user 'mvp'
  group 'mvp'
  action :sync
  notifies :run, 'execute[build]'
end

# builds only if necessary/changes
execute 'build' do
  user "mvp"
  command 'make clean all'
  cwd node['mvp']['home']
  action :nothing
end

firewall_rule 'open port 8000' do
  port 8000
  command :allow
end
