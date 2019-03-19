module FroalaEditorSDK

  # Video functionality.
  class Video < File

    # Default options that are used if no options are passed to the upload function
    @default_options = {
        fieldname: 'file',
        validation: {
            allowedExts: [".mp4", ".webm", ".ogg"],
            allowedMimeTypes: [ "video/mp4", "video/webm", "video/ogg" ]
        },
        resize: nil
    }

    # Default upload path.
    @default_upload_path = "public/uploads/videos"
  end
end