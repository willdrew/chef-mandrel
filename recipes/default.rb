#
# Cookbook Name:: mandrel
# Recipe:: default
#
# Copyright 2013, Will Drew
#

Chef::Log.info "Loading: #{cookbook_name}::#{recipe_name}"

include_recipe 'mandrel::_install'
