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
    return '.'
  end
end

count = 0
origins = {}

### plot origin points
grid = Array.new(350) {Array.new(350, '.')}
input = File.read('input6.txt').split("\n").each do |coordinate|
  origins[count] = coordinate.split(', ').map!(&:to_i)
  grid[origins[count][0]][origins[count][1]] = count
  count += 1
end

### assign district bounds
grid.each_with_index do |row, row_idx|
  row.each_with_index do |col, col_idx|
    next unless grid[row_idx][col_idx] == '.'
    grid[row_idx][col_idx] = closest_origin([row_idx, col_idx], origins)
  end
end