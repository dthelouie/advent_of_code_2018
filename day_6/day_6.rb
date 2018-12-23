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

def get_area(coordinates_1, coordinates_2)
  (coordinates_1[0] - coordinates_2[0]).abs * (coordinates_1[1] - coordinates_2[1]).abs
end

count = 0
origins = {}

### plot origin points
grid = Array.new(350) {Array.new(350, '.')}
input = File.read('input6.txt').split("\n").sort.each do |coordinate|
  origins[count] = coordinate.split(', ').map!(&:to_i)
  grid[origins[count][0]][origins[count][1]] = count
  count += 1
end

### assign district bounds
grid.each_with_index do |row, row_idx|
  row.each_with_index do |col, col_idx|
    grid[row_idx][col_idx] = closest_origin([row_idx, col_idx], origins)
  end
end

### eliminate edges from selection process
edges = (grid[0] + grid[-1] + grid.transpose[0] + grid.transpose[-1]).flatten.uniq.sort

zone = {point_1: nil, point_2: nil, area: 0}
origins.each do |key_1, coordinates_1|
  next if edges.include?(key_1)
  origins.each do |key_2, coordinates_2|
    next if edges.include?(key_2) || key_1 == key_2
    area = get_area(coordinates_1, coordinates_2)
    if area > zone[:area]
      zone[:area] = area 
      zone[:point_1] = {key: key_1, coordinates: coordinates_1}
      zone[:point_2] = {key: key_2, coordinates: coordinates_2}
    end
  end
end

puts zone