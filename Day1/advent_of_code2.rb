
input_file_name = "advent_of_code_input.txt"
if File.file?(input_file_name)
  # steps_string  = File.open("advent_of_code_input.txt").read.to_s
  lines = File.readlines("advent_of_code_input.txt")
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

total = 0
lines.each do |step|
  inline_total = 0
  mass = step.to_f
# mass = 1969
  loop do
    required_gas = (mass/3.0).floor - 2 >=0 ? (mass/3.0).floor - 2 : 0
    # inline_total += (mass + required_gas)
    inline_total += required_gas
    break if required_gas <=0
    mass = required_gas
  end

  total +=inline_total

 end
puts total
