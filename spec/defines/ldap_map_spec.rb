require 'spec_helper'

describe 'postfix::ldap_map', :type => :define do
  let(:facts) { {:operatingsystem => 'Ubuntu', :operatingsystemrelease => '14.04'} }
  let(:title) { 'ldap_allusers' }
  let(:params) { {:ensure => 'present', :value => 'foo' } }
  
  it 'should create a file for the map' do
    should contain_file('/etc/postfix/ldap_allusers.cf')
  end
end
