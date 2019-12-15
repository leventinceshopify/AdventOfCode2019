
input_file_name = "day10input.txt"

if File.file?(input_file_name)
  # steps_string  = File.open("advent_of_code_input.txt").read.to_s
  lines = File.readlines(input_file_name)

else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

my_ast_array = Array.new
lines.each do |line|
  line.each_char do |c|
    my_ast_array.push(1) if c=="#"
    my_ast_array.push(0) if c=="."
  end

end
my_hash = Hash.new(0)
max_hit = 0
my_ast_array.each_with_index do |element, index |

  if element == 1
    x = index/48
    y = index % 48
    tmp_hash = Hash.new(0)

    my_ast_array.each_with_index do |e, i|
      if e == 1 && i != index
        x1 = i/48
        y1 = i % 48
        x_rate = x1-x
        y_rate = y1-y
        rate = x_rate.to_f / y_rate.to_f
        tmp_hash[[element, rate ]] = 1 if i< index
        tmp_hash[[-element, rate ]] = 1 if i >index
      end
    end
    my_hash[[x,y]] = tmp_hash.size
  end
  if my_hash[[x,y]] > max_hit
    max_hit = my_hash[[x,y]]
  end
end

puts "Max hit = #{max_hit}"
