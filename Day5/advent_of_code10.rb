
input_file_name = "day5input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end
steps = steps_string.split(",")

increment_index = true
arr_pos = 0
i = 0
loop do

  if i == arr_pos
    increment_index = true
    instructionArray = steps[i].to_s.split("")

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

    if first_param_mode == 0
      first_operand_value = steps[steps[i+1].to_i].to_i
    else
      first_operand_value =  steps[i+1].to_i
    end

    if second_param_mode == 0
      second_operand_value = steps[steps[i+2].to_i].to_i
    else
      second_operand_value =  steps[i+2].to_i
    end
    if opcode == 1
      address_to_be_written = steps[i+3].to_i
      steps[address_to_be_written] = first_operand_value + second_operand_value
      arr_pos = arr_pos + 4
    elsif opcode == 2
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

    elsif opcode == 5
      if first_operand_value != 0
        arr_pos = second_operand_value
        increment_index = false

      else
        arr_pos = arr_pos + 3
      end
    elsif opcode == 6
      if first_operand_value == 0
        arr_pos = second_operand_value
        increment_index = false
      else
        arr_pos = arr_pos + 3
      end

    elsif opcode == 7
      address_to_be_written = steps[i+3].to_i
      if first_operand_value < second_operand_value

        steps[address_to_be_written] = 1

      else
        steps[address_to_be_written] = 0
      end
      arr_pos = arr_pos + 4

    elsif opcode == 8
      address_to_be_written = steps[i+3].to_i
      if first_operand_value == second_operand_value

        steps[address_to_be_written] = 1

      else
        steps[address_to_be_written] = 0
      end
      arr_pos = arr_pos + 4


    elsif opcode == 99
      break

    end

  end


i+=1 #if increment_index

 break if i == steps.length - 1
end

puts steps[0]
