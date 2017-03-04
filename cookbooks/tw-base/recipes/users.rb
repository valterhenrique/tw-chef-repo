#
# Cookbook:: tw-base
# Recipe:: users
#
# Copyright:: 2017, The Authors, All Rights Reserved.

node['tw-base']['groups'].each do |group|
   users_manage group do
     action [ :remove, :create ]
     data_bag 'users'
   end
 end
