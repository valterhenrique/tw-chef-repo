#
# Cookbook:: tw-base
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "tw-base::firewall"
include_recipe "tw-base::packages"
include_recipe "tw-base::services"
include_recipe "tw-base::users"
