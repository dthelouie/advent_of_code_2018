def frequency_repeat(input, total=[0])
  current = total[-1].to_i
  input.each do |change|
    current += change.to_i
    return current if total.include?(current)
    total << current
  end
  return frequency_repeat(input, total)
end

puts frequency_repeat(File.read('1_input.txt').split("\n"))