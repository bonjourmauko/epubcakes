require 'rubygems'
require 'bundler'
Bundler.require

set :environment, :production
set :port, 3000
disable :run, :reload

run "config/jobs.rb"
require 'init'

run Epubcakes::Init.new