input_file_name = "day8input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end
layers = steps_string.scan(/.{150}/)
final_message = ""
(0..149).each do |i|
  layers.each do |layers|
    if layers[i] != '2'
      final_message = final_message + layers[i]
      break
    end
  end
end
msg_arr= final_message.split("")
msg_arr.collect! do |v|
 (v == '0') ? " " : "*"
end
msg_arr.each_with_index  do |v,i|
print " "
if (i+1) % 25 == 0
  puts ""
 end
 print v
end
