#
# Cookbook Name:: mandrel
# Attributes:: _install
#
# Copyright 2013, Will Drew
#
#  default['mandrel']['pip'] hash:
#
#  'install'             => 'true'                            # default is false
#  'version'             => '0.0.4b'                          # optional, defaults to false
#  'virtualenv'          => '/home/ubunut/virtualenvs/myapp'  # optional, defaults to false

default['mandrel']['pip']['install'] = false
default['mandrel']['pip']['version'] = false
default['mandrel']['pip']['virtualenv'] = false
