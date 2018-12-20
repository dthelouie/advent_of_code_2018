# grid = Array.new(1000) { Array.new(1000) }
# data = []

# input = File.read('input3.txt').split("\n").map do |line|
#   match = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(line)
#   id = match[1].to_i
#   left = match[2].to_i
#   top = match[3].to_i
#   width = match[4].to_i
#   height = match[5].to_i
#   right = left + width
#   bottom = top + height

#   (top...bottom).to_a.each do |row|
#     (left...right).to_a.each do |col|
#       data << [id, width, height]
#       grid[row][col] = [] unless grid[row][col]
#       grid[row][col] << id unless grid[row][col].include?(id)
#     end
#   end
#   {id: id, width: width, height: height}
# end

# puts data.find { |id, width, height| grid.flatten(1).count { |a| a == [id] } == width * height }[0]

input = File.read('input3.txt').chomp.split("\n").map do |d|
  d.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
end

grid = Array.new(1000) { Array.new(1000) }
data = []

input.map(&:to_a).map { |a| a.map(&:to_i) }.each do |_, id, left, top, width, height|
  data << [id, left, top, width, height]
  (top..top + height - 1).each do |row|
    (left..left + width - 1).each do |col|
      grid[row][col] = [] unless grid[row][col]
      grid[row][col] << id
    end
  end
end

puts data.find { |id, _, _, width, height| grid.flatten(1).count { |a| a == [id] } == width * height }[0]