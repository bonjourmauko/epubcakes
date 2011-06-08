require 'rubygems'
require 'bundler'
Bundler.require

set :environment, :production
set :port, 3000
disable :run, :reload

require 'init'

run EmpaquePulento::Init.new