# rspec helper
#
# MANAGED BY MODULESYNC
# https://code.immerda.ch/netlab/puppet/modulesync.git

require 'octofacts'
require 'rake'
require 'rspec-puppet'
require 'rspec-puppet-utils'

if ENV['DEBUG']
  Puppet::Util::Log.level = :debug
  Puppet::Util::Log.newdestination(:console)
else
  Puppet::Util::Log.level = :warning
  Puppet::Util::Log.newdestination(:console)
end

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))
hiera_path   = File.expand_path(File.join(__FILE__, '..', 'hiera'))

RSpec.configure do |c|
  c.module_path     = File.join(fixture_path, 'modules')
  c.manifest_dir    = File.join(fixture_path, 'manifests')
  c.pattern         = FileList[c.pattern].exclude(/^spec\/fixtures/)
  c.hiera_config    = File.join(hiera_path, 'hiera.yaml')
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end

ENV["OCTOFACTS_FIXTURE_PATH"] ||= File.expand_path("fixtures/facts/octofacts", File.dirname(__FILE__))
ENV["OCTOFACTS_INDEX_PATH"]   ||= File.expand_path("fixtures/facts/octofacts-index.yaml", File.dirname(__FILE__))
