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
