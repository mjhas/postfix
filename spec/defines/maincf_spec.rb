require 'spec_helper'

describe 'postfix::config::maincf', :type => :define do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  let(:title) { 'foo' }
  let(:params) { {:ensure => 'present', :value => 'foo' } }
  it 'should have an augeas resource' do
	should contain_augeas('postfix main.cf foo')
  end
  describe_augeas 'postfix main.cf foo', :lens => 'postfix_main', :target => 'etc/postfix/main.cf' do
    it 'foo should exist with value foo' do
      should execute.with_change

      aug_get('foo').should == 'foo' 

      should execute.idempotently
    end
  end
end

describe 'postfix::config::maincf', :type => :define do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  let(:title) { 'bar' }
  let(:params) { {:ensure => 'absent' } }
  it 'should have an augeas resource' do
	should contain_augeas('postfix main.cf bar')
  end
  describe_augeas 'postfix main.cf bar', :lens => 'postfix_main', :target => 'etc/postfix/main.cf' do
    it 'bar should not exist' do
      should execute.with_change

      aug_get('bar').should == nil

      should execute.idempotently
    end
  end
end

