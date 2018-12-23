require 'pry'

def closest_origin(starting_point, origins)
  distance = nil
  closest = []
  origins.each do |key, coordinates|
    diff = (starting_point[0] - coordinates[0]).abs + (starting_point[1] - coordinates[1]).abs
    if distance.nil? || diff < distance
      closest = [key]
      distance = diff
    elsif diff == distance
      closest << key
    end
  end
  if closest.length == 1
    return closest[0]
  else
    return closest
  end
end

count = 1
origins = {}

### plot origin points
grid = Array.new(350) {Array.new(350, '.')}
input = File.read('input6.txt').split("\n").map {|line| line.split(', ').map {|axis| axis.to_i}}.sort.each do |coordinate|
  origins[count] = coordinate
  grid[origins[count][0]][origins[count][1]] = count
  count += 1
  origins[count - 1]
end

### assign district bounds
grid.each_with_index do |row, row_idx|
  row.each_with_index do |col, col_idx|
    grid[row_idx][col_idx] = closest_origin([row_idx, col_idx], origins) unless origins.values.include?([row_idx, col_idx])
  end
end

### eliminate edges from selection process
edges = (grid[0] + grid[-1] + grid.transpose[0] + grid.transpose[-1]).flatten.uniq.sort

cells = grid.flatten(1)
areas = ((1..50).to_a - edges).map do |number|
  [number, cells.count(number)]
end

puts areas.max {|a, b| a[1] <=> b[1]}