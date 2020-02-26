require "bundler/setup"
require "pry"

Dir[File.join(__dir__, "/*.rb")].each do |file|
    require file
  end

run Sinatra::Application
