#
# Cookbook Name:: mandrel
# Provider:: pylog
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
    # Always use logging.cfg for the filename
    path = ::File.join(new_resource.dir_path, 'logging.cfg')

    if new_resource.file
      source_type = 'cookbook_file'
      source_file = new_resource.file
      source_variables = nil
    elsif new_resource.template
      source_type = 'template'
      source_file = new_resource.template
      source_variables = new_resource.variables
    else
      raise "#{new_resource}: is misconfigured, it needs a valid value for either the template or cookbook_file attribute"
    end

    send(source_type, path) do
      cookbook          new_resource.cookbook
      source            source_file
      variables         source_variables          if source_type == 'template'
      owner             new_resource.owner        if new_resource.owner
      group             new_resource.group        if new_resource.group
      mode              mode                      if new_resource.mode
      action :create
    end
  end
end

action :delete do
  converge_by "Delete #{new_resource} at #{new_resource.dir_path}" do
    path = ::File.join(new_resource.dir_path, 'logging.cfg')

    file path do
      action :delete
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::MandrelPylog.new(new_resource.name)
end
