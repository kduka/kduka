require "font-awesome-sass"

module WYSIWYG
  module Rails
    class Engine < ::Rails::Engine
      initializer 'froala.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %W(
          froala_editor.min.js
          plugins/*.js
          languages/*.js
          froala_editor.min.css
          froala_style.min.css
          plugins/*.css
          themes/*.css
        )
      end
    end
  end
end