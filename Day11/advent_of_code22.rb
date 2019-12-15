
input_file_name = "day11input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

steps = steps_string.split(",")

$current_position = [100, 100]
$paint_hash = Hash.new(0);

$direction_array = ["North", "East", "South", "West"]
$index = 0

input_ins = 1
is_first_output = true
is_second_output = false

arr_pos = 0
i = 0
rel_base = 0
output_array = []

def move_robot(direction)
  $index =   direction == 1  ?    ($index + 1) % 4 :  ($index -1 + 4) % 4
  current_direction = $direction_array[$index]
  if current_direction == "North"
    $current_position[1] += 1
  elsif current_direction == "East"
    $current_position[0] += 1
  elsif current_direction == "South"
    $current_position[1] -= 1
  else
    $current_position[0] -= 1
  end
end
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
      first_param_mode = instructionArray[instructionArray.length-3].to_i
    else
      first_param_mode =  0
    end
    if instructionArray.length-4 >=0
      second_param_mode = instructionArray[instructionArray.length-4].to_i
    else
      second_param_mode = 0
    end
    if instructionArray.length-5 >=0
      third_param_mode = instructionArray[instructionArray.length-5].to_i
    else
      third_param_mode = 0
    end
    if first_param_mode == 0
      first_operand_value = steps[steps[i+1].to_i].to_i
    elsif first_param_mode == 2
      first_operand_value = steps[steps[i+1].to_i + rel_base].to_i
    else
      first_operand_value =  steps[i+1].to_i
    end

    if second_param_mode == 0
      second_operand_value = steps[steps[i+2].to_i].to_i
    elsif second_param_mode == 2
      second_operand_value = steps[steps[i+2].to_i + rel_base].to_i
    else
      second_operand_value =  steps[i+2].to_i
    end

    if third_param_mode == 0
      third_operand_value = steps[i+3].to_i
    elsif third_param_mode == 2
      third_operand_value = steps[i+3].to_i + rel_base
    else
      third_operand_value =  steps[i+3].to_i
    end
    if opcode == 1
      address_to_be_written = steps[i+3].to_i
      steps[third_operand_value] = first_operand_value + second_operand_value
      arr_pos = arr_pos + 4
    elsif opcode == 2
      address_to_be_written = steps[i+3].to_i
      steps[third_operand_value] = first_operand_value * second_operand_value
      arr_pos = arr_pos + 4
    elsif opcode == 3
      first_input_element = input_ins
      if first_param_mode == 0
        steps[steps[i+1].to_i]=first_input_element
      elsif first_param_mode == 2
        steps[steps[i+1].to_i+rel_base]=first_input_element
      else
        steps[i+1]=first_input_element
      end
      steps[steps[i+1].to_i]=first_input_element
      arr_pos = arr_pos + 2
    elsif opcode == 4

      output_element = first_operand_value #steps[steps[i+1].to_i].to_i
      # puts "Output element #{output_element}"
      arr_pos = arr_pos + 2
      if is_first_output
        is_first_output = false
        x =$current_position[0]
        y =$current_position[1]
        $paint_hash[[x,y]] = output_element
      else
        is_first_output = true
        move_robot(output_element)
        input_ins = $paint_hash[$current_position]
      end
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
        steps[third_operand_value] = 1
      else
        steps[third_operand_value] = 0
      end
      arr_pos = arr_pos + 4
    elsif opcode == 8
      address_to_be_written = steps[i+3].to_i
      if first_operand_value == second_operand_value
        steps[third_operand_value] = 1
      else
        steps[third_operand_value] = 0
      end
      arr_pos = arr_pos + 4
    elsif opcode == 9
      rel_base = rel_base + first_operand_value
      arr_pos = arr_pos + 2
    elsif opcode == 99
      puts "IN 99"
      puts "IN 99"
      puts "steps length : #{steps.length}"
      break
    end
  end
  i = arr_pos -1
  i+=1 #if increment_index
  break if i == steps.length - 1
end
(0..40000).each do |i|
  x = i % 200
  y = i /200

  if $paint_hash[[x,y]] == 1
    print "*"
  else
    print " "
  end
  puts" " if  i% 200 ==0
end
