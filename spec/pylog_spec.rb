#
# Cookbook Name:: mandrel
# Spec:: pylog_spec
#
# Copyright 2013, Will Drew
#
## Note that this recipe is strictly intended for testing
## the mandrel's pylog resource and not intended for use in a
## "real" chef run.

require 'chefspec'

describe 'mandrel_pylog resource' do
  let :chef_run do
    ChefSpec::ChefRunner.new(:step_into => ['mandrel_pylog'])
  end

  let :attr_setter do
    chef_run.node.set['mandrel']['pylog_test']
  end

  let :attr_getter do
    chef_run.node['mandrel']['pylog_test']
  end

  subject do
    chef_run.converge 'mandrel::pylog_test'
  end

  before do
    attr_setter['dir_path'] = '/some/project/release/current/conf'
    attr_setter['action'] = :create
    attr_setter['owner'] = 'some_owner'
    attr_setter['group'] = 'some_group'
    attr_setter['mode'] = '0444'
  end

  context 'with all attributes specified' do
    # Test default template, custom template, cookbook_file
    source_types = {
      :default_template => {
        :content_regexp => /\[logger\_root\]\nlevel\=INFO/m,
        :resource_attrs => {}
      },
      :custom_template => {
        :content_regexp => /\[logger\_template_test\]\nlevel\=WARN/m,
        :resource_attrs => {
          :template => 'tests/logging_test.cfg.erb',
          :variables => { :logger_level => 'WARN' }
        }
      },
      :cookbook_file => {
        :content_regexp => /\[logger\_file_test\]\nlevel\=DEBUG/m,
        :resource_attrs => {
          :file => 'tests/logging_test.cfg',
        }
      }
    }

    source_types.each do |source_type, attrs|
      it "should create a logging.cfg file from #{source_type} at the specified path" do
        set_resource_attrs(attrs[:resource_attrs])
        expect(subject).to create_file_with_content '/some/project/release/current/conf/logging.cfg',
                                                    /^#{attrs[:content_regexp]}$/m
      end
    end

    it 'should set path to the specified permissions' do
      file = subject.template '/some/project/release/current/conf/logging.cfg'
      expect(file).to be_owned_by('some_owner', 'some_group')
      expect(file.mode).to eq '0444'
    end
  end

  context 'with no mode' do
    it 'should default to mode 0444 given nil' do
      attr_setter['mode'] = nil
      file = subject.template '/some/project/release/current/conf/logging.cfg'
      expect(file.mode).to eq '0444'
    end

    it 'should blow up given empty string' do
      attr_setter['mode'] = ''
      error_msg = 'Option mode\'s value  does not match regular expression /\A\d?[0-7]{3,4}\z/'
      ::Chef::ExpectException.expect(Chef::Exceptions::ValidationFailed, error_msg)
      expect { subject.template '/some/project/release/current/conf/logging.cfg' }.to raise_error(Chef::Exceptions::ValidationFailed, error_msg)
    end
  end

  it 'should use the :create action by default' do
    attr_setter['action'] = nil
    expect(subject).to create_file '/some/project/release/current/conf/logging.cfg'
  end

  it 'should delete the file on :delete' do
    attr_setter['action'] = :delete
    expect(subject).to delete_file '/some/project/release/current/conf/logging.cfg'
  end
end

def set_resource_attrs(attrs)
  attrs.each do |key, value|
    if key.respond_to? :each
      key.each do |k, v|
        attr_setter[key.to_s][k.to_s] = v
      end
    else
      attr_setter[key.to_s] = value
    end
  end if attrs
end
