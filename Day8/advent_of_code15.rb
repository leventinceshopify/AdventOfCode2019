input_file_name = "day8input.txt"
if File.file?(input_file_name)
  steps_string  = File.open(input_file_name).read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

layers = steps_string.scan(/.{150}/)
fewest_zero_layer = ""
fewest_zero_layer_count = 150
layers.each do |layer|
  if layer.count('0') < fewest_zero_layer_count
    fewest_zero_layer_count = layer.count('0')
    fewest_zero_layer  =  layer
  end
end
# puts fewest_zero_layer
# puts fewest_zero_layer_count
number_of_ones = fewest_zero_layer.count('1')
number_of_two = fewest_zero_layer.count('2')
puts result = number_of_ones  * number_of_two
