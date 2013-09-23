#
# Cookbook Name:: mandrel
# Provider:: default
#
# Copyright 2013, Will Drew
#

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  converge_by "Create #{new_resource} at #{new_resource.dir_path}" do
    # Force mode if string is emptry for some strange reason
    mode = (new_resource.mode.empty? ? '0444' : new_resource.mode) if new_resource.mode
    # Always use Mandrel.py for the filename
    path = ::File.join(new_resource.dir_path, 'Mandrel.py')

    template path do
      source 'Mandrel.py.erb'
      cookbook new_resource.cookbook if new_resource.cookbook
      owner new_resource.owner if new_resource.owner
      group new_resource.group if new_resource.group
      mode mode if new_resource.mode
      variables :search_paths => new_resource.search_paths.inspect,
                :logging_config_basename => new_resource.logging_config_basename
      action :create
    end
  end
end

action :delete do
  converge_by "Delete #{new_resource} at #{new_resource.dir_path}" do
    path = ::File.join(new_resource.dir_path, 'Mandrel.py')

    file path do
      action :delete
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::Mandrel.new(new_resource.name)
end
