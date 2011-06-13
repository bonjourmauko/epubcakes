require 'cloudfiles'
require 'storage'
include Stalker


job "epub" do |args|
  epub = Epubcakes::Storage::Epub.new
  epub.download args['container']
  epub.zip!
  epub.upload('ebooks', args['container'])
  epub.flush!
end

error do |e|
  e.to_json
end