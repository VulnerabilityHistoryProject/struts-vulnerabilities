require 'yaml'
def validate_ymls(dir_path)
  dir_path = dir_path + '/*.yml'
  Dir.glob(dir_path) do |file_path|
    file_txt = read_file(file_path)
    begin
      Psych.parse(file_txt, file_path)
    rescue Psych::SyntaxError => ex
      puts "Validation failed:" + ex.message
    end
  end
  puts "Done"
end

def read_file(file_path)
  if File.file?(file_path)
    return File.read(file_path).chomp
  else
    return nil
  end
end

# Process directory
if(File.directory?(ARGV[0]))
  dir = ARGV[0]
else
  abort("Invalid first argument. Please use a valid directory name")
end

validate_ymls(dir)
