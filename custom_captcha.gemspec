# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "custom_captcha/version"

Gem::Specification.new do |s|
  s.name        = "custom_captcha"
  s.version     = CustomCaptcha::VERSION
  s.date        = Date.today
  s.authors     = ["vkill"]
  s.email       = ["vkill.net@gmail.com"]
  s.homepage    = "https://github.com/vkill/custom_captcha"
  s.summary     = "A simple and custom captcha for Rails3."
  s.description = "A simple and custom captcha for Rails3."

  s.rubyforge_project = "custom_captcha"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rails", "~> 3.1.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "therubyracer"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "capybara"
  s.add_development_dependency "rake"
  s.add_dependency "activesupport", "~> 3.1.0"
  s.add_dependency "i18n"
  s.add_dependency "rmagick", "~> 2.13.1"
  s.add_dependency "mini_magick", "~> 3.3"

end

