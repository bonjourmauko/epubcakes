require 'rubygems'
require 'config/daemon'
require 'bundler'
Bundler.require

set :environment, :production
set :port, 3000
disable :run, :reload

require 'init'

run Epubcakes::Init.new