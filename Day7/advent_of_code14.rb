
input_file_name = "day7input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

steps = steps_string.split(",")
$instruction_pause_hash = Hash.new()
$instruction_pause_hash["a"]=[].concat(steps)
$instruction_pause_hash["b"] =[].concat(steps)
$instruction_pause_hash["c"] =[].concat(steps)
$instruction_pause_hash["d"] =[].concat(steps)
$instruction_pause_hash["e"] =[].concat(steps)
$instruction_pause_hash2 = Hash.new(0)

def amplifier(phase, input_elem, number_of_run, which_ampl)
  steps = $instruction_pause_hash[which_ampl]
  receive_phase_input = true
  finish_condition = false
  output_element =0
  arr_pos = 0
  arr_pos = $instruction_pause_hash2[which_ampl]
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
        if receive_phase_input == true && number_of_run == 0
          first_input_element = phase
          receive_phase_input = false
        else
          first_input_element = input_elem
        end
        steps[steps[i+1].to_i]=first_input_element
        arr_pos = arr_pos + 2
      elsif opcode == 4
        output_element = steps[steps[i+1].to_i].to_i
        $instruction_pause_hash2[which_ampl] = arr_pos + 2
        $instruction_pause_hash[which_ampl] = steps
        break if arr_pos = arr_pos + 2
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
        finish_condition = true
        break
      end
    end
    i+=1
    if i == steps.length - 1
      i=0
      $instruction_pause_hash2[which_ampl]=0
    end
  end
  # puts "End of Amplifier  #{which_ampl}    #{[output_element, finish_condition]}"
  return [output_element, finish_condition]
end

def generate_perm_array()
  a = [9,8,7,6,5]
  return a.permutation(5).to_a
end
phase_array = generate_perm_array()
max_thrust = 0
phase_array.each do |p|
  l_counter = 0
  e1=[0, false]
  $instruction_pause_hash2["a"] = 0
  $instruction_pause_hash2["b"] = 0
  $instruction_pause_hash2["c"] = 0
  $instruction_pause_hash2["d"] = 0
  $instruction_pause_hash2["e"] = 0

  $instruction_pause_hash["a"]=[].concat(steps)
  $instruction_pause_hash["b"] =[].concat(steps)
  $instruction_pause_hash["c"] =[].concat(steps)
  $instruction_pause_hash["d"] =[].concat(steps)
  $instruction_pause_hash["e"] =[].concat(steps)

  loop do
    if e1[0] > max_thrust
      max_thrust = e1[0]
    end
    a1 = amplifier( p[0], e1[0], l_counter, "a")
    b1 = amplifier( p[1], a1[0], l_counter, "b")
    c1 = amplifier( p[2], b1[0], l_counter, "c")
    d1 = amplifier( p[3], c1[0], l_counter, "d")
    e1 = amplifier( p[4], d1[0], l_counter, "e")

    if e1[0] > max_thrust
      max_thrust = e1[0]
    end
    break if e1[1]
    l_counter+=1
    break if l_counter ==10
  end
end
puts "Max Thrust #{max_thrust}"
