# Instert multiple lines into all yml files in a directory
def insertLinesDir(dir_path, line_above_regex, text)
  # replace tabs with spaces
  text = text.gsub(/\t/,'  ')
  regex = /#{line_above_regex}/
  dir_path = dir_path + '/*.yml'
  puts dir_path
  Dir.glob(dir_path) do |file|
    puts "file: " + file.to_s
    insertLine(regex, text, file)
  end
end


# inserts a single line into all yml files in a directory
def insertLineDir(line_above_regex, text, dir_path)
  regex = /#{line_above_regex}/
  dir_path = dir_path + '/*.yml'
  puts dir_path
  Dir.glob(dir_path) do |file|
    insertLine(regex, text, file)
  end
end


# inserts a single line into a single file
def insertLine(regex, text, file_path)
  newymltxt = ""
  puts file_path
  file = File.open(file_path, "r")
  file.each_line do |line|
    newymltxt << line
    if(regex.match(line))
      newymltxt << "\n" + text + "\n"
    end
  end
  saveyml(file_path, newymltxt)
end


# get the lines you want to insert into file line by line
def readInputLines()
  puts "Enter your input. When finished press \'Tab\' then \'Enter'\."
  #detect a tab with an enter and remove them from the end
  input = gets("\t\n").chomp("\t\n")
  input
end


def readFile(file_path)
  if File.file?(file_path)
    return File.read(file_path).chomp
  else
    return nil
  end
end


def saveyml(file_path, txt)
  File.open(file_path, 'w+') {|f| f.write(txt)}
    puts "Saved " + file_path
end



puts "WARNING: PLEASE BACKUP ALL CVES IN CHOSEN DIRECTORY BEFORE USING THIS SCRIPT"
puts "Remember to manually add the text to the skeleton file"
dir_path = ""
args = []
ARGV.each {|str| args.push(str)}
ARGV.clear
if(File.directory?(args[0]))
  dir_path = args[0]
else
  abort("Invalid first argument. Please use a valid directory name")
end
regex = args[1]
input = ""
if(args[2].casecmp?("manual"))
  input = readInputLines()
elsif(File.file?(args[2]))
  input = readFile(args[2])
else
  abort("Invalid third argument. Please use either a file name or \'manual\'")
end
insertLinesDir(dir_path, regex, input)
