require 'fileutils'

module Epubcakes
  module Storage

    BASE_PATH = Dir.pwd + "/factory"

    class Connection
      def initialize(token)
        @token = token
        @@credentials ||= YAML.load_file('config/cloudfiles.yml')
        @connection = CloudFiles::Connection.new(:username => @@credentials['username'], :api_key => @@credentials['api_key'])
      end
    end

    class Epub < Epubcakes::Storage::Connection
      def initialize(token)
        super(token)
      end

      def upload(container_name, dirname)
        container = @connection.create_container container_name
        file_path = "#{dirname}/ebook.epub"
        full_path = BASE_PATH + @token + "/" + 'ebook.epub'

        file = File.open full_path, "r"
        object = container.create_object file_path
        object.write file
        file.close

        output = { :file_path => file_path }
      end

      def download(container_name)
        container = @connection.container container_name
        container.objects.each do |object|
          object_path = object.send(:gsub, /^[\/]/, '')
          full_path = BASE_PATH + @token + "/" + object_path
          FileUtils.mkpath File.dirname(full_path)

          object = container.object object.dup

          file = File.open full_path, "w"
          file.write object.data
          file.close
        end
      end

      #fix
      def zip!
        system "cd #{BASE_PATH + @token}; zip -X0 'ebook.epub' mimetype; zip -rDX9 'ebook.epub' * -x '*.DS_Store' -x mimetype"
      end

      #fix
      def flush!
        system "cd #{BASE_PATH}; rm -rf #{@token}"
      end
    end
  end
end