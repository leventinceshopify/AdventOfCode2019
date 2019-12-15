
cypher_counter = 0
(145852..616942).each do |key|
adj_condition = false
order_condition = true
arr = key.to_s.split("")
  arr.each_with_index do |e, i|
    if i < arr.length-1
      adj_condition = true if arr[i] == arr[i+1]
    end
    if i < arr.length-1
      order_condition = false if arr[i].to_i > arr[i+1].to_i
    end
  end
if adj_condition && order_condition
cypher_counter += 1
end
end
puts cypher_counter
