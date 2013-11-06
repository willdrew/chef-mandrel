#
# Cookbook Name:: mandrel
# Spec:: default_spec
#
# Copyright 2013, Will Drew
#
## Note that this recipe is strictly intended for testing
## the mandrel's default resource and not intended for use in a
## "real" chef run.

require 'chefspec'

describe 'mandrel resource' do
  let :chef_run do
    ChefSpec::ChefRunner.new(:step_into => ['mandrel'])
  end

  let :attr_setter do
    chef_run.node.set['mandrel']['default_test']
  end

  let :attr_getter do
    chef_run.node['mandrel']['default_test']
  end

  subject do
    chef_run.converge 'mandrel::default_test'
  end

  before do
    attr_setter['dir_path'] = '/some/project/release/current'
    attr_setter['action'] = :create
    attr_setter['owner'] = 'some_owner'
    attr_setter['group'] = 'some_group'
    attr_setter['mode'] = '0444'
  end

  context 'with all attributes specified' do
    it 'should create a Mandrel.py file from template at the specified path' do
      expect(subject).to create_file_with_content '/some/project/release/current/Mandrel.py',
                                                  /^bootstrap.SEARCH_PATHS.extend\(\[\"conf\", \"\~\/conf\"\]\)\n\nbootstrap.LOGGING_CONFIG_BASENAME\s=\s\"logging.cfg\"$/m
    end

    it 'should set path to the specified permissions' do
      file = subject.template '/some/project/release/current/Mandrel.py'
      expect(file).to be_owned_by('some_owner', 'some_group')
      expect(file.mode).to eq '0444'
    end
  end

  context 'with no mode' do
    it 'should default to mode 0444 given nil' do
      attr_setter['mode'] = nil
      file = subject.template '/some/project/release/current/Mandrel.py'
      expect(file.mode).to eq '0444'
    end

    it 'should blow up given empty string' do
      attr_setter['mode'] = ''
      error_msg = 'Option mode\'s value  does not match regular expression /\A\d?[0-7]{3,4}\z/'
      ::Chef::ExpectException.expect(Chef::Exceptions::ValidationFailed, error_msg)
      expect { subject.template '/some/project/release/current/Mandrel.py' }.to raise_error(Chef::Exceptions::ValidationFailed, error_msg)
    end
  end

  it 'should use the :create action by default' do
    attr_setter['action'] = nil
    expect(subject).to create_file '/some/project/release/current/Mandrel.py'
  end

  it 'should delete the file on :delete' do
    attr_setter['action'] = :delete
    expect(subject).to delete_file '/some/project/release/current/Mandrel.py'
  end
end
