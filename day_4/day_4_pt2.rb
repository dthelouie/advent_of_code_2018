require 'time'

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

input = File.read('input4.txt').split("\n").sort

index = 0
sleepy_minute = {guard: nil, minute: nil, quantity: 0}
while index < input.length
  if input[index].include?("falls asleep")
    asleep = get_time(input[index])
    awake = get_time(input[index + 1])
    get_minutes(asleep, awake).each do |minute|
      patrols[guard_id][minute] += 1
      if patrols[guard_id][minute] > sleepy_minute[:quantity]
        sleepy_minute[:guard] = guard_id
        sleepy_minute[:minute] = minute
        sleepy_minute[:quantity] = patrols[guard_id][minute]
      end
    end
  else 
    guard_id = /Guard #(\d+) begins shift/.match(input[index])[1].to_i
    patrols[guard_id] = Hash.new(0) unless patrols[guard_id]
  end
  index += 1
  index += 1 if input[index].include?("wakes up")
end

puts sleepy_minute[:guard] * sleepy_minute[:minute]