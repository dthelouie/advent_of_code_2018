def box_list(input)
  boxes = []
  has_two = 0
  has_three = 0
  input.each do |line|
    counts = Hash.new(0)
    line.split('').each do |letter|
      counts[letter] += 1
    end
    if counts.values.include?(2)
      has_two += 1 
      boxes << line
    end
    if counts.values.include?(3)
      has_three += 1 
      boxes << line unless boxes.include?(line)
    end
  end
  return boxes
end

def almost_match?(input_a, input_b)
  return false if input_a == input_b
  index = 0
  diffs = 0
  same = []
  until index > input_a.length || index > input_b.length
    if input_a[index] != input_b[index]
      diffs += 1
      return false if diffs > 1
    else
      same << input_a[index]
    end
    index += 1
  end
  return same
end

list = box_list(File.read('input2.txt').split("\n")).sort

matches = Hash.new
list.each do |box_a|
  list.each do |box_b|
    match = almost_match?(box_a, box_b)
    matches[box_a] = match.join if match
  end
end

puts matches