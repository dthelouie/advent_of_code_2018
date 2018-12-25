require 'pry'

sample = ["Step C must be finished before step A can begin.",
          "Step C must be finished before step F can begin.",
          "Step A must be finished before step B can begin.",
          "Step A must be finished before step D can begin.",
          "Step B must be finished before step E can begin.",
          "Step D must be finished before step E can begin.",
          "Step F must be finished before step E can begin."].join("\n")

rules = {}

def requirements(letter, rules)
  rules.select {|rule, values| values.include?(letter.upcase)}.keys
end

def rule_breaker?(letter, order, rules)
  return true if order.include?(letter)
  before = requirements(letter, rules)
  return !(before - order).empty?
end

def find_next(letter, order, rules)
  return false if rules[letter].nil?
  rules[letter].each do |piece|
    next if order.include?(piece)
    return piece unless rule_breaker?(piece, order, rules)
  end
  return false
end

### set up hash map
input = File.read('input7.txt').split("\n").each do |line|
# input = sample.split("\n").each do |line|
  match = /Step (.) must be finished before step (.) can begin\./.match(line)
  rules[match[1]] ||= []
  rules[match[2]] ||= []
  rules[match[2]] << match[1]
  rules[match[2]].sort!
end

order = []

until rules.empty?
  e = rules.select {|k,v| v.empty?}.keys.sort[0]
  rules.delete(e)
  rules.each {|k,v| v.delete(e)}
  order << e
end
puts order.join

# ### define first values
# first = (rules.keys - rules.values.flatten).sort

# ### left to assemble
# assembly = rules.values.flatten.uniq.sort

# first.each do |letter|
#   order << letter
#   index = -1
#   to_add = []
#   until index.abs > order.length
#     next_piece = find_next(order[index], order, rules)
#     if next_piece
#       order << next_piece
#       to_add << next_piece
#       index = -1
#     else
#       index -= 1
#     end
#     assembly.delete(next_piece)
#   end
#   puts to_add.join
# end

# puts order.join

# def check(order, rules)
#   rules.each do |key, rule|
#     rule.each do |letter|
#       puts "wrong" unless order.index(key) < order.index(letter)
#     end
#   end
# end
