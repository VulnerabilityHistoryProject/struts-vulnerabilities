def insertLinesDir(line_above_regex, dir_path)
  text = readInput()
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

def readInput()
  allinput =""
  while (line = gets) != "\n"
    allinput << line
  end
  allinput.chomp
end

def saveyml(file_path, txt)
  File.open(file_path, 'w+') {|f| f.write(txt)}
    puts "Saved " + file_path
end

puts "Enter the regex for the line above: "
line_above = gets.chomp
#puts "Enter the text you want to insert: "
#text = gets.chomp
puts "Enter the dir path:"
dir_path = gets.chomp
insertLinesDir(line_above, dir_path)
puts "Done"
