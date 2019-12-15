include Math
input_file_name = "day10input.txt"
if File.file?(input_file_name)
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
size = 48
my_hash = Hash.new(0)
max_hit = 0
result = 0
my_ast_array.each_with_index do |element, index |

  if element == 1
    x = index % size
    y = index / size
    tmp_hash = Hash.new(0)
    my_ast_array.each_with_index do |e, i|
      if e == 1 && i != index
        x1 = i%size
        y1 = i / size
        x_rate = x-x1
        y_rate = y-y1

        rate = atan2(x_rate, -y_rate)
        tmp_hash[[ rate ]] = 1
      end
    end
    my_hash[[x,y]] = tmp_hash
  end
  if my_hash[[x,y]].size > max_hit
    max_hit = my_hash[[x,y]].size
    result =  [x,y]
  end
end
puts "result = #{result}"
puts "Max hit = #{max_hit}"

final_arr = []
my_hash[result].each do |k, v|
  final_arr.push(k)
end
# The 200th asteroid corresponds to index 198 (because index starts from 0 and don't count the current itself)
puts sta=  final_arr.sort![198]
puts result[0]
puts result[1]
tp_arr = []
final_hash = Hash.new(0)
my_ast_array.each_with_index do |e, i|
  if e==1
    xt = i%size
    yt = i/size
    x_rate = result[0]-xt
    y_rate = result[1]-yt

    rate = atan2(x_rate, -y_rate)
    tp_arr.push(rate)
    tp_arr.uniq!
    if rate.round(7) == sta[0].round(7)
      puts "HIT HIT"
      final_hash[[xt, yt]] = rate
    end
  end

end

puts final_hash
