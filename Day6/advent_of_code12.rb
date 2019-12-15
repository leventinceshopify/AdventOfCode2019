
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

# puts "Total number of orbits is #{total}"
# puts "total number of input is #{steps_string.length}"
s1 ="YOU"
s2 ="SAN"
common_parents = Hash.new
nodes_hash.each do |key, value|
  if  value.include?(s1 ) && value.include?(s2 )
    common_parents[key] = value
  end
end
# puts "Common parents are : #{common_parents}"
first_common_parent = ""
inc_flag = false
common_parents.each do |k1, v1|
  common_parents.each do |k2, v2|
    if nodes_hash[k1].include?(k2)
      common_parents[k1] = nil
    end
end
end
common_parents.each do |k, v|
  if !common_parents[k].nil?
    first_common_parent = k
  end
end
# puts "firat comoon parent : #{first_common_parent}"
counterYOU = 0
counterSAN = 0
# puts nodes_hash[first_common_parent]
nodes_hash[first_common_parent].each do |key|
if !nodes_hash[key].nil?
  counterYOU +=1  if nodes_hash[key].include?("YOU")
  counterSAN +=1  if nodes_hash[key].include?("SAN")
end
end
puts "SAN is #{counterSAN},   YOU is #{counterYOU} total is : #{counterSAN + counterYOU}"
