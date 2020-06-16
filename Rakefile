# Rakefile
#
# MANAGED BY MODULESYNC
# https://code.immerda.ch/netlab/puppet/modulesync.git

require 'bundler'
Bundler.require(:rake)
require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'

PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
  config.disable_checks = ["class_inherits_from_params_class", "80chars"]
  config.fail_on_warnings = true
  config.log_format = '%{path}:%{line}:%{KIND}: %{message}'
end

RSpec::Core::RakeTask.new(:spec) do |t|
  modulepath = File.expand_path(File.join(__FILE__, '..'))
  modulename = File.basename(modulepath)
  linkpath = File.join(modulepath, 'spec', 'fixtures', 'modules', modulename)
  unless Dir.exists?(File.dirname(linkpath))
    Dir.mkdir(File.dirname(linkpath))
  end
  puts 'Install Puppet module dependencies'
  unless File.exists?(linkpath)
    File.symlink(modulepath, linkpath)
  end
  system('librarian-puppet install --path=' + File.join('spec', 'fixtures', 'modules'))
  t.pattern = 'spec/classes/*_spec.rb'
end

# vim: syntax=ruby
