#
# Cookbook Name:: mandrel
# Recipe:: default_test
#
# Copyright 2013, Will Drew
#
## Note that this recipe is strictly intended for testing
## the mandrel's default resource and not intended for use in a
## "real" chef run.

attrs = node['mandrel']['default_test']

mandrel attrs['dir_path'] do
  action                   attrs['action']                   if attrs['action']
  owner                    attrs['owner']                    if attrs['owner']
  group                    attrs['group']                    if attrs['group']
  mode                     attrs['mode']                     if attrs['mode']
  search_paths             attrs['search_paths']             if attrs['search_paths']
  logging_config_basename  attrs['logging_config_basename']  if attrs['logging_config_basename']
end
