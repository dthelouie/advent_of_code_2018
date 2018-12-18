def box_id_checksum(input)
  has_two = 0
  has_three = 0
  input.each do |line|
    counts = Hash.new(0)
    line.split('').each do |letter|
      counts[letter] += 1
    end
    has_two += 1 if counts.values.include?(2)
    has_three += 1 if counts.values.include?(3)
  end
  puts "two: #{has_two}"
  puts "three: #{has_three}"
  return has_two * has_three
end

puts box_id_checksum(File.read('input2.txt').split("\n"))