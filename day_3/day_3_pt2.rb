grid = Array.new(1000) { Array.new(1000, []) }

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
      grid[row][col] << id
    end
  end
end

solo = []

grid.each do |row|
  row.each do |cell|
    next if cell.uniq.length > 1
    solo << cell.uniq[0] unless solo.include?(cell.uniq[0]) || cell.uniq[0].nil?
  end
end

puts solo