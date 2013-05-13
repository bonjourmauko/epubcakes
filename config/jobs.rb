require 'digest/md5'
require 'fileutils'
require 'cloudfiles'
require 'storage'
include Stalker


job "epub" do |args|
  token = Digest::MD5.hexdigest rand(36**32).to_s(36)
  epub = Epubcakes::Storage::Epub.new token
  epub.download args['container']
  epub.zip!
  params = epub.upload('ebooks', args['container'])
  Nestful.post "tapir.heroku.com/master", :params => params
  epub.flush!
end

error do |e|
  e.to_json
end