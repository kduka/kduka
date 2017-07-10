namespace :check_js do
  JS_PATH = "app/assets/javascripts/**/*.js";
  Dir[JS_PATH].each do |file_name|
    puts "\n#{file_name}"
    puts Uglifier.compile(File.read(file_name))
  end
end
