# Gemfile
#
# MANAGED BY MODULESYNC
# https://code.immerda.ch/netlab/puppet/modulesync.git

source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

group :test do
  gem 'librarian-puppet',    :require => false
  gem 'octofacts',           :require => false
  gem 'puppet-lint',         :require => false
  gem 'rake',                :require => false
  gem 'rspec-puppet',        :require => false
  gem 'rspec-puppet-utils',  :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion.to_s, :require => false, :groups => [:test]
else
  gem 'facter', :require => false, :groups => [:test]
end

ENV['PUPPET_VERSION'].nil? ? puppetversion = '~> 6.0' : puppetversion = ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
