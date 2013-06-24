require 'bundler/gem_tasks'

require 'rake'
require 'rake/testtask'

Rake::TestTask.new :spec do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs.push 'spec'
end

task :default => [:spec]
