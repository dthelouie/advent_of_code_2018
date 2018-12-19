grid = Array.new(1000) { Array.new(1000, 0) }

input = File.read('input3.txt').split("\n").map do |line|
  match = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(line)
  id = match[1].to_i
  left = match[2].to_i
  top = match[3].to_i
  width = match[4].to_i
  height = match[5].to_i
  right = left + width
  bottom = top + height

  (top...bottom).to_a.each do |row|
    (left...right).to_a.each do |col|
      grid[row][col] += 1
    end
  end
end

puts "overlaps: #{grid.flatten.count {|e| e > 1}}"

