### what is the size of the region containing all locations which have a sum total distance of under 10000
### how many spaces in the grid have a sum of distances from all provided coordinates less than 10000?

def manhattan(current, reference)
  return (current[0] - reference[0]).abs + (current[1] - reference[1]).abs
end

origins = {}
count = 1

### plot origin points
grid = Array.new(350) {Array.new(350, '.')}
input = File.read('input6.txt').split("\n").map {|line| line.split(', ').map {|axis| axis.to_i}}.sort.each do |coordinate|
  origins[count] = coordinate
  grid[origins[count][0]][origins[count][1]] = count
  count += 1
  origins[count - 1]
end

nearby = []

grid.each_with_index do |row, row_index|
  row.each_with_index do |col, col_index|
    manhattan_sum = 0
    origins.each do |key, coordinates|
      manhattan_sum += manhattan([row_index, col_index], coordinates)
      break if manhattan_sum > 10000
    end
    nearby << manhattan_sum if manhattan_sum < 10000
  end
end

puts nearby.length