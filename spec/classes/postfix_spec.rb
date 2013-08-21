require 'spec_helper'

describe 'postfix', :type => :class do
#  let(:title) { 'postfix::relay' }
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  it { should contain_package('postfix') }
  it { should contain_service('postfix') }
end

