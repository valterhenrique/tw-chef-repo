#
# Cookbook:: tw-mvp
# Recipe:: packages
#
# Copyright:: 2017, The Authors, All Rights Reserved.

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
  notifies :run, 'execute[build]', :immediately
end

# builds only if necessary/changes
execute 'build' do
  user "mvp"
  command 'make libs && make clean all'
  cwd node['mvp']['home']
  action :nothing
end

firewall_rule 'open port 8000' do
  port 8000
  command :allow
end

template '/etc/mvp_frontend' do
  owner 'root'
  group 'root'
  mode '0600'
  source 'mvp_frontend_env.erb'
end

directory '/etc/systemd/system/mvp.service.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

%w(mvp_frontend mvp_quote mvp_newsfeed).each do |srvc|
  template "/etc/systemd/system/#{srvc}.service" do
    owner 'root'
    group 'root'
    mode '0755'
    source "#{srvc}.service.erb"
  end

  service "#{srvc}" do
    supports :status => true, :stop => true, :restart => true, :reload => true
    action [:enable, :start]
    subscribes :reload, "template[/etc/systemd/system/#{srvc}.service]", :immediately
  end
end
