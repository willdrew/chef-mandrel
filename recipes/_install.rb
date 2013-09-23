#
# Cookbook Name:: mandrel
# Recipe:: _install
#
# Copyright 2013, Will Drew
#

Chef::Log.info "Loading: #{cookbook_name}::#{recipe_name}"

mandrel               = node['mandrel']
pip                   = node['mandrel']['pip']
install               = pip['install']
version               = pip['version']
virtualenv            = pip['virtualenv']


python_pip "mandrel" do
  version version if version
  virtualenv virtualenv if virtualenv
  action :install
end if install
