#encoding: utf-8

require "rubygems"
require "bundler/setup"

require "custom_captcha"

namespace :custom_captcha do
  desc "Generate {count} captcha images."
  task :generate, [:count] do |t, args|
    args.with_defaults(:count => 3)
    count = args[:count].to_i
    CustomCaptcha::Image.create(count) do |number, n, state, image_file|
      puts "[%s/%s] %s generating %s" % [ n, number, state, image_file ]
    end
  end

  desc "Clear all captcha images."
  task :clear_all do |t|
    print "\rclearing all captcha images..."
    CustomCaptcha::Utils.clear_all_image_files()
    print "done\n"
  end
end

