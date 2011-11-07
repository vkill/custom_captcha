require "bundler/gem_tasks"
Dir["lib/tasks/**/*.rake"].each { |ext| load ext }

if File.exist?(File.expand_path('../config/application.rb', __FILE__))
  require File.expand_path('../config/application', __FILE__)
  CustomCaptcha::RailsRailtie.load_tasks
end

