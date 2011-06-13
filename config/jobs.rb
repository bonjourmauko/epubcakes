require 'digest/md5'
require 'fileutils'
require 'cloudfiles'
require 'storage'
include Stalker


job "epub" do |args|
  token = Digest::MD5.hexdigest rand(50**length).to_s(50)
  epub = Epubcakes::Storage::Epub.new token
  epub.download args['container']
  epub.zip!
  epub.upload('ebooks', args['container'])
  epub.flush!
end

error do |e|
  e.to_json
end