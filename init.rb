require 'fileutils'
require 'yajl/json_gem'
require 'storage'

module Epubcakes
  class Init < Sinatra::Base
    
    mime_type :json, 'application/json'
    
    before do
      content_type :json
    end
    
    # ???
    post "/" do
      begin
        epub = Epubcakes::Storage::Epub.new
        epub.download params[:container]
        epub.zip
        response = epub.upload('ebooks', params[:container])
        epub.flush
        response.to_json
      rescue => e
        error 500, e.message.to_json
      end
    end
  
  end
end