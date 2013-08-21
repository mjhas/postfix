require 'spec_helper'

describe 'postfix::config::mastercf', :type => :define do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  let(:title) { 'foo' }
  let(:params) { {:ensure => 'present'} }
  it 'should have an augeas resource' do
	should contain_augeas('postfix master.cf foo')
  end
  describe_augeas 'postfix master.cf foo', :lens => 'postfix_master', :target => 'etc/postfix/master.cf' do
    it 'foo should exist with type unix' do
      should execute.with_change

      aug_get('foo/type').should == 'unix' 

      should execute.idempotently
    end
  end
end

describe 'postfix::config::mastercf', :type => :define do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  let(:title) { 'virtual' }
  let(:params) { {:ensure => 'absent' } }
  it 'should have an augeas resource' do
	should contain_augeas('postfix master.cf virtual')
  end
  describe_augeas 'postfix master.cf virtual', :lens => 'postfix_master', :target => 'etc/postfix/master.cf' do
    it 'virtual should not exist' do
      should execute.with_change

      aug_get('virtual').should == nil
      aug_get('virtual/type').should == nil

      should execute.idempotently
    end
  end
end

describe 'postfix::config::mastercf', :type => :define do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  let(:title) { 'qmgr' }
  let(:params) { {
	:ensure => 'present',
	:type => 'unix',
	:private => '-',
	:unprivileged => 'n',
	:chroot => 'n',
	:wakeup => '-',
	:limit => '-',
	:command => 'virtual',
  } }
  it 'should have an augeas resource' do
	should contain_augeas('postfix master.cf qmgr')
  end
  describe_augeas 'postfix master.cf qmgr', :lens => 'postfix_master', :target => 'etc/postfix/master.cf' do
    it 'qmgr should stay the same' do
      should execute

      aug_get('qmgr/type').should == 'unix' 
      aug_get('qmgr/private').should == '-' 
      aug_get('qmgr/unprivileged').should == 'n' 
      aug_get('qmgr/chroot').should == 'n' 
      aug_get('qmgr/wakeup').should == '-' 
      aug_get('qmgr/limit').should == '-' 
      aug_get('qmgr/command').should == 'virtual' 

      should execute.idempotently
    end
  end
end

