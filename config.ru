require "bundler/setup"
require "pry"
require "httparty"

Dir[File.join(__dir__, "/*.rb")].each do |file|
    require file
  end

run Sinatra::Application
