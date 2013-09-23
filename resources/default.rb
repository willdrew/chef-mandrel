#
# Cookbook Name:: mandrel
# Resource:: default
#
# Copyright 2013, Will Drew
#

actions :create, :delete
default_action :create

attribute :dir_path,                :kind_of => String,         :name_attribute => true,          :required => true
attribute :cookbook,                :kind_of => String,         :default => 'mandrel',            :required => true
attribute :owner,                   :kind_of => String,         :default => 'root'
attribute :group,                   :kind_of => String,         :default => 'root'
attribute :mode,                    :kind_of => String,         :default => '0444',               :regex => /\A\d?[0-7]{3,4}\z/
attribute :search_paths,            :kind_of => Array,          :default => ['conf', '~/conf']
attribute :logging_config_basename, :kind_of => String,         :default => 'logging.cfg'

def initialize(*args)
  super
  @action = :create
end
