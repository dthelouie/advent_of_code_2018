def frequency(input)
  freq = 0
  input.each do |number|
    freq += number.to_i
  end
  return freq
end
puts frequency(File.read('1_input.txt').split("\n"))