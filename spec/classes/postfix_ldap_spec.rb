require 'spec_helper'

describe 'postfix::ldap', :type => :class do
  let(:facts) { {:operatingsystem => 'Ubuntu', :operatingsystemrelease => '14.04'} }
  let(:title) { 'foo' }
  
  it 'should install the package' do
    should contain_package('postfix_ldap')
  end
end