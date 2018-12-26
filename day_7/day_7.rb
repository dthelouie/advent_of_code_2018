sample = ["Step C must be finished before step A can begin.",
          "Step C must be finished before step F can begin.",
          "Step A must be finished before step B can begin.",
          "Step A must be finished before step D can begin.",
          "Step B must be finished before step E can begin.",
          "Step D must be finished before step E can begin.",
          "Step F must be finished before step E can begin."].join("\n")

rules = {}

### set up hash map of rules
input = File.read('input7.txt').split("\n").each do |line|
# input = sample.split("\n").each do |line|
  match = /Step (.) must be finished before step (.) can begin\./.match(line)
  requirement = match[1]
  piece = match[2]
  rules[requirement] ||= []
  rules[piece] ||= []
  rules[piece] << requirement
  rules[piece].sort!
end

order = []

def find_next(rules)
  rules.select {|letter, requirements| requirements.empty?}.keys.sort[0]
end

until rules.empty?
  next_piece = find_next(rules)
  order << next_piece
  rules.delete(next_piece)
  rules.each {|piece, requirements| requirements.delete(next_piece)}
end

puts order.join