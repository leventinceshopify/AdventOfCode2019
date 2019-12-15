
input_file_name = "day6input.txt"
if File.file?(input_file_name)
  steps_string  = File.readlines(input_file_name)

else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

nodes_hash = Hash.new(nil)
steps_string.each do |orbit|
  arr = orbit.split(":")
  if nodes_hash[arr[0]].nil?
    nodes_hash[arr[0]] = [arr[1].delete!("\n")]
  else
    nodes_hash[arr[0]].push(arr[1].delete!("\n"))
  end
end
nodes_hash.each do |k, v|
  nodes_hash.each do |key, value|
    if  value.include?(k)
      nodes_hash[key].concat(v).uniq!
    end
  end
end
total = 0
nodes_hash.each do |key, value|
  total = total + value.length
end

puts "Total number of orbits is #{total}"
# puts "total number of input is #{steps_string.length}"
