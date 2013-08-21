require 'spec_helper'

describe 'postfix::relay', :type => :class do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  let(:title) { 'foo' }
  let(:params) { {
	:relayhost          => 'example.org',
  	:masquerade_domains => 'relay.example.org'
  } }
  it 'should have an augeas resource' do
	should contain_augeas('postfix main.cf relayhost')
	should contain_augeas('postfix main.cf masquerade_domains')
  end
  describe_augeas 'postfix main.cf relayhost', :lens => 'postfix_main', :target => 'etc/postfix/main.cf' do
    it 'relay should be set to example.org' do
      should execute.with_change

      aug_get('relayhost').should == 'example.org' 

      should execute.idempotently
    end
  end
  describe_augeas 'postfix main.cf masquerade_domains', :lens => 'postfix_main', :target => 'etc/postfix/main.cf' do
    it 'masquerade_domains should be set to relay.example.org' do
      should execute.with_change

      aug_get('masquerade_domains').should == 'relay.example.org' 

      should execute.idempotently
    end
  end
end

