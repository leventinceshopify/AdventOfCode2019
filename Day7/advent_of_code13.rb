
input_file_name = "day7input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end
steps = steps_string.split(",")
def amplifier(steps, phase, input_elem)
  receive_phase_input = true
  output_element =0
  arr_pos = 0
  i = 0
  loop do
    if i == arr_pos
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
        if receive_phase_input == true
          first_input_element = phase
          receive_phase_input = false
        else
          first_input_element = input_elem
        end
        steps[steps[i+1].to_i]=first_input_element
        arr_pos = arr_pos + 2
      elsif opcode == 4
        output_element = steps[steps[i+1].to_i].to_i
        # puts "Output element #{output_element}"
        arr_pos = arr_pos + 2
      elsif opcode == 5
        first_operand_value = first_param_mode==1 ?  steps[i+1].to_i : steps[steps[i+1].to_i].to_i
        second_operand_value = second_param_mode==1 ?  steps[i+2].to_i : steps[steps[i+2].to_i].to_i
        if first_operand_value != 0
          arr_pos = second_operand_value
        else
          arr_pos = arr_pos + 3
        end
      elsif opcode == 6
        first_operand_value = first_param_mode==1 ?  steps[i+1].to_i : steps[steps[i+1].to_i].to_i
        second_operand_value = second_param_mode==1 ?  steps[i+2].to_i : steps[steps[i+2].to_i].to_i
        if first_operand_value == 0
          arr_pos = second_operand_value
        else
          arr_pos = arr_pos + 3
        end
      elsif opcode == 7
        first_operand_value = first_param_mode==1 ?  steps[i+1].to_i : steps[steps[i+1].to_i].to_i
        second_operand_value = second_param_mode==1 ?  steps[i+2].to_i : steps[steps[i+2].to_i].to_i
        address_to_be_written = steps[i+3].to_i
        if first_operand_value < second_operand_value
          steps[address_to_be_written] = 1
        else
          steps[address_to_be_written] = 0
        end
        arr_pos = arr_pos + 4
      elsif opcode == 8
        first_operand_value = first_param_mode==1 ?  steps[i+1].to_i : steps[steps[i+1].to_i].to_i
        second_operand_value = second_param_mode==1 ?  steps[i+2].to_i : steps[steps[i+2].to_i].to_i
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
    i+=1
    if i == steps.length - 1
      break
    end
  end
  return output_element
end

def generate_perm_array()
  a = [0,1,2,3,4]
  return a.permutation(5).to_a
end
phase_array = generate_perm_array()
max_thrust = 0
phase_array.each do |p|
  a1 = amplifier(steps, p[0], 0)
  b1 = amplifier(steps, p[1], a1)
  c1 = amplifier(steps, p[2], b1)
  d1 = amplifier(steps, p[3], c1)
  e1 = amplifier(steps, p[4], d1)
  if e1 > max_thrust
    max_thrust = e1
  end
end

puts max_thrust
