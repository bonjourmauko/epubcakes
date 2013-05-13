require 'yajl/json_gem'
require 'storage'
require 'daemon'

module Epubcakes
  class Init < Sinatra::Base

    mime_type :json, 'application/json'

    before do
      content_type :json
    end

    post "/" do
      begin
        Stalker.enqueue("epub", :container => params[:container]).to_json
      rescue => e
        error 500, e.message.to_json
      end
    end

  end
end