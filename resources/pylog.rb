#
# Cookbook Name:: mandrel
# Resource:: pylog
#
# Copyright 2013, Will Drew
#

actions :create, :delete
default_action :create

attribute :dir_path,                :kind_of => String,         :name_attribute => true,          :required => true
attribute :cookbook,                :kind_of => String,         :default => 'mandrel',            :required => true
attribute :file,                    :kind_of => String
attribute :template,                :kind_of => String,         :default => 'logging.cfg.erb'
attribute :variables,               :kind_of => Hash,           :default => { :logger_level => 'INFO' }
attribute :owner,                   :kind_of => String,         :default => 'root'
attribute :group,                   :kind_of => String,         :default => 'root'
attribute :mode,                    :kind_of => String,         :default => '0444',               :regex => /\A\d?[0-7]{3,4}\z/

def initialize(*args)
  super
  @action = :create
end
