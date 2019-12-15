
input_file_name = "day5input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

steps = steps_string.split(",")
arr_pos = 0
steps.each_with_index do |element, i|
  if i == arr_pos
    instructionArray = element.to_s.split("")
    if instructionArray.length-2 >= 0
      opcode = (instructionArray[instructionArray.length-2] + instructionArray[instructionArray.length-1]).to_i
    else
      opcode = (instructionArray[instructionArray.length-1]).to_i
    end

    if instructionArray.length-3 >=0
      first_param_mode = instructionArray[instructionArray.length-3].to_i == 1 ? 1 : 0

    else
      first_param_mode =  0
    end
    if instructionArray.length-4 >=0
      second_param_mode = instructionArray[instructionArray.length-4].to_i == 1 ? 1 : 0
    else
      second_param_mode = 0
    end
    if opcode == 1
      first_operand_value = first_param_mode==1 ?  steps[i+1].to_i : steps[steps[i+1].to_i].to_i
      second_operand_value = second_param_mode==1 ?  steps[i+2].to_i : steps[steps[i+2].to_i].to_i
      address_to_be_written = steps[i+3].to_i
      steps[address_to_be_written] = first_operand_value + second_operand_value
      arr_pos = arr_pos + 4
    elsif opcode == 2
      first_operand_value = first_param_mode==1 ?  steps[i+1].to_i : steps[steps[i+1].to_i].to_i
      second_operand_value = second_param_mode==1 ?  steps[i+2].to_i : steps[steps[i+2].to_i].to_i
      address_to_be_written = steps[i+3].to_i
      steps[address_to_be_written] = first_operand_value * second_operand_value
      arr_pos = arr_pos + 4
    elsif opcode == 3
      first_input_element = gets.chomp.to_i
      steps[steps[i+1].to_i]=first_input_element
      arr_pos = arr_pos + 2
    elsif opcode == 4

      output_element = steps[steps[i+1].to_i].to_i
      puts "Output element #{output_element}"
      arr_pos = arr_pos + 2

    elsif opcode == 99
      break

    end

  end

end

puts steps[0]
