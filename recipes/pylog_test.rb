#
# Cookbook Name:: mandrel
# Recipe:: pylog_test
#
# Copyright 2013, Will Drew
#
## Note that this recipe is strictly intended for testing
## the mandrel's pylog resource and not intended for use in a
## "real" chef run.

attrs = node['mandrel']['pylog_test']

mandrel_pylog attrs['dir_path'] do
  action                   attrs['action']                   if attrs['action']
  owner                    attrs['owner']                    if attrs['owner']
  group                    attrs['group']                    if attrs['group']
  mode                     attrs['mode']                     if attrs['mode']
  cookbook                 attrs['cookbook']                 if attrs['cookbook']
  file                     attrs['file']                     if attrs['file']
  template                 attrs['template']                 if attrs['template']
  variables                attrs['variables']                if attrs['variables']
end
