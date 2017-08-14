begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "-f doc"
  end

  task :default => :spec
rescue LoadError
  raise "No Rspec available"
end
