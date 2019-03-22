module FroalaEditorSDK

  require 'fileutils'

  # File functionality.
  class File

    # Default options that are used if no options are passed to the upload function
    @default_options = {
        fieldname: 'file',
        validation: {
            allowedExts: [".txt", ".pdf", ".doc", ".json", ".html"],
            allowedMimeTypes: [ "text/plain", "application/msword", "application/x-pdf", "application/pdf", "application/json","text/html" ]
        },
        resize: nil
    }

    # Default upload path.
    @default_upload_path = "public/uploads/files"

    # Uploads a file to the server.
    # Params:
    # +params+:: File upload parameter mostly is "file".
    # +upload_path+:: Server upload path, a storage path where the file will be stored.
    # +options+:: Hash object that contains configuration parameters for uploading a file.
    # Returns json object
    def self.upload(params, upload_path = @default_upload_path, options = {})

      # Merge options.
      options = @default_options.merge(options)

      file = params[options[:fieldname]]

      if file

        # Validates the file extension and mime type.
        validation = Validation.check(file, options)

        # Uses the Utlis name function to generate a random name for the file.
        file_name = Utils.name(file)
        path = Rails.root.join(upload_path, file_name)

        # Saves the file on the server and returns the path.
        serve_url = save(file, path)

        resize(options, path) if !options[:resize].nil?

        return {:link => serve_url}.to_json
      else
        return nil
      end
    end

    # Saves a file on the server.
    # Params:
    # +file+:: The uploaded file that will be saved on the server.
    # +path+:: The path where the file will be saved.
    def self.save (file, path)

      # Create directory if it doesn't exist.
      dirname = ::File.dirname(path)
      unless ::File.directory?(dirname)
        ::FileUtils.mkdir_p(dirname)
      end

      if ::File.open(path, "wb") {|f| f.write(file.read)}

        # Returns a public accessible server path.
        return "#{"/uploads/"}#{Utils.get_file_name(path)}"
      else
        return "error"
      end
    end

    # Deletes a file found on the server.
    # Params:
    # +file+:: The file that will be deleted from the server.
    # +path+:: The server path where the file resides.
    # Returns true or false.
    def self.delete(file = params[:file], path)

      file_path = Rails.root.join(path, ::File.basename(file))
      if ::File.delete(file_path)
        return true
      else
        return false
      end
    end

    # Resizes an image based on the options provided.
    # The function resizes the original file,
    # Params:
    # +options+:: The options that contain the resize hash
    # +path+:: The path where the image is stored
    def self.resize (options, path)
      image = MiniMagick::Image.new(path)
      image.path
      image.resize("#{options[:resize][:height]}x#{options[:resize][:width]}")
    end

    class << self
      attr_reader :var
    end

    def var
      self.class.var
    end
  end
end