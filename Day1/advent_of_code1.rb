
input_file_name = "advent_of_code_input.txt"
if File.file?(input_file_name)
  # steps_string  = File.open("advent_of_code_input.txt").read.to_s
  lines = File.readlines(input_file_name)
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

total = 0
lines.each do |step|
total +=(step.to_f/3.0).floor - 2


end
puts total
