#
# Cookbook:: tw-audit-cis
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "tw-audit-cis::1-initial-setup"
include_recipe "tw-audit-cis::2-services"
include_recipe "tw-audit-cis::4-logging-and-auditing"
