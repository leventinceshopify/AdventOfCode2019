
double_element_hash = Hash.new
cypher_counter = 0
(145852..616942).each do |key|
  adj_condition = false
  there_is_one = false
  adj_condition2 = true
  order_condition = true
  arr = key.to_s.split("")
  arr.each_with_index do |e, i|
    element = 10
    if i < arr.length-1
      if arr[i] == arr[i+1]
        element = arr[i]
        double_element_hash[[key, element]] =  1 if !(double_element_hash[[key, element]] ==  -1)
      end
      if i< arr.length-2
        if (element ==  arr[i+2])
          double_element_hash[[key, element]] =  -1
        end
      end

    end

    (0..5).each do |j|
      if (double_element_hash[[key, arr[j]]] ==  1)
        adj_condition = true
      end
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
