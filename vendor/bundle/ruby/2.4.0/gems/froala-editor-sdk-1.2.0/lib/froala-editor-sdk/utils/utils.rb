module FroalaEditorSDK

  # Basic utility functionality.
  class Utils

    # Generates a random name that will be used as name for files.
    def self.name (file)
      name = SecureRandom.urlsafe_base64
      ext = ::File.extname(file.original_filename)

      return "#{name}#{ext}"
    end

    # Returns file name from an file path
    def self.get_file_name(path)
      return ::File.basename(path)
    end
  end
end