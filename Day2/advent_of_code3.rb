
input_file_name = "day2input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end


steps = steps_string.split(",")

steps[1] = 12
steps[2] = 2

counter = 0
steps.each do |element|

  if counter % 4 == 0

    i = counter

    if element.to_i == 1
      first_add_element = steps[steps[i+1].to_i].to_i
      second_add_element = steps[steps[i+2].to_i].to_i
      steps[steps[i+3].to_i] = second_add_element + first_add_element
    elsif element.to_i == 2
      first_mul_element = steps[steps[i+1].to_i].to_i
      second_mul_element = steps[steps[i+2].to_i].to_i
      steps[steps[i+3].to_i] = second_mul_element * first_mul_element
    elsif element.to_i == 99
      break

    else
      puts "There is an error"
    end

  end
  counter+=1
end

puts steps[0]
