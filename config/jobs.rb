include Stalker

job "epub" do |container|
  epub = Epubcakes::Storage::Epub.new
  epub.download container
  epub.zip!
  epub.upload('ebooks', container)
  epub.flush!
end

error do |e|
  e.to_json
end