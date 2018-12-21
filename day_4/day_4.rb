require 'time'
require 'pry'

patrols = {}
guard_id = 0

def get_time(string)
  match = /\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2})\]/.match(string)
  Time.parse(match[1])
end

def get_minutes(start, finish)
  minutes = []
  while start < finish
    minutes << start.min
    start += 60
  end
  return minutes
end

def most_asleep(patrols)
  most = {guard: nil, minute: 0, quantity: 0}
  patrols.each do |guard, minutes|
    if minutes.values.flatten.length > most[:quantity]
      most[:guard] = guard
      most[:quantity] = minutes.flatten.length
      most[:minute] = minutes.to_a.max { |a, b| a[1] <=> b[1] }[0]
    end
  end
  return most
end

input = File.read('input4.txt').split("\n").sort

index = 0
while index < input.length
  # puts input[index]
  if input[index].include?("falls asleep")
    asleep = get_time(input[index])
    # puts input[index + 1] if input[index + 1].include?("wakes up")
    awake = get_time(input[index + 1])
    get_minutes(asleep, awake).each do |minute|
      patrols[guard_id][minute] += 1
    end
  else 
    guard_id = /Guard #(\d+) begins shift/.match(input[index])[1].to_i
    patrols[guard_id] = Hash.new(0) unless patrols[guard_id]
  end
  index += 1
  index += 1 if input[index].include?("wakes up")
end

sleepy = most_asleep(patrols)
puts "guard #{sleepy[:guard]}, minute #{sleepy[:minute]}, #{sleepy[:quantity]} total minutes"
puts sleepy[:guard] * sleepy[:minute]
