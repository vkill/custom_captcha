#encoding: utf-8

require "rubygems"
require "bundler/setup"

require "custom_captcha"

namespace :custom_captcha do
  desc "Generate {count} captcha images."
  task :generate_images, [:count] => :environment do |t, args|
    args.with_defaults(:count => 3)
    count = args[:count].to_i
    CustomCaptcha::Utils.generate_image_files(count) do |number, n, state, image_file|
      puts "           -  [%s/%s] %s Generating %s" % [ n, number, state.capitalize!, image_file ]
    end
  end

  desc "Clear all captcha images."
  task :clear_all_images => :environment do |t|
    print "\r           -  Clearing all captcha images..."
    CustomCaptcha::Utils.clear_all_image_files()
    print "done\n"
  end

end

