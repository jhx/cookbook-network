# encoding: utf-8
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |config|
  config.before :all do
    config.path = '/sbin:/usr/sbin'
  end # config.before

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end # config.expect_with
end # RSpec

# returns true if platform family matches value (accepts :symbol or 'string')
# rubocop:disable CyclomaticComplexity
def os?(value)
  os = backend.check_os
  case value.to_s
  when 'debian' then os[:family] == 'Debian'
  when 'rhel' then os[:family] == 'RedHat'
  when 'rhel5' then os[:family] == 'RedHat' && os[:release].to_i == 5
  when 'rhel6' then os[:family] == 'RedHat' && os[:release].to_i == 6
  else false
  end # case
end # def
# rubocop:enable CyclomaticComplexity
