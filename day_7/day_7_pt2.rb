sample = ["Step C must be finished before step A can begin.",
          "Step C must be finished before step F can begin.",
          "Step A must be finished before step B can begin.",
          "Step A must be finished before step D can begin.",
          "Step B must be finished before step E can begin.",
          "Step D must be finished before step E can begin.",
            "Step F must be finished before step E can begin."].join("\n")

class AssemblyLine
  attr_reader :time, :workers, :order
  attr_accessor :rules

  def initialize(workers)
  @rules = {}
  @workers = []
  workers.times do
  @workers << {time: 0, piece: nil}
  end
  @order = []
  @time = 0
  @letter_timing = {}
  letters = ('A'..'Z').to_a
  letters.each do |letter|
  @letter_timing[letter] = letters.index(letter) + 61

  ### testing
  # @letter_timing[letter] = letters.index(letter) + 1
  end
  end

  def add_time(letter)
    worker = @workers.index({time: 0, piece: nil})
    if worker
      @workers[worker][:time] += @letter_timing[letter]
      @workers[worker][:piece] = letter
      puts "worker #{worker + 1} is working on piece #{letter} (#{@letter_timing[letter]} seconds)"
    else
      puts 'all workers are busy'
      pass_time
      add_time(letter)
    end
  end

  def pass_time(seconds = nil)
    times = @workers.collect{|worker| worker[:time]}
    times.delete(0)
    seconds = times.min unless seconds
    @workers.each do |worker|
      worker[:time] -= seconds unless worker[:time] == 0
      if worker[:time] == 0 && worker[:piece] != nil 
        order << worker[:piece]
        rules.each {|piece, requirements| requirements.delete(worker[:piece])}
        worker[:piece] = nil
      end
    end
    @time += seconds
  end

  def find_next
    @rules.select {|letter, requirements| requirements.empty?}.keys.sort
  end 

end

assembly_line = AssemblyLine.new(5)

### testing
# assembly_line = AssemblyLine.new(2)

### set up hash map of rules
input = File.read('input7.txt').split("\n").each do |line|
# input = sample.split("\n").each do |line|
match = /Step (.) must be finished before step (.) can begin\./.match(line)
requirement = match[1]
piece = match[2]
assembly_line.rules[requirement] ||= []
assembly_line.rules[piece] ||= []
assembly_line.rules[piece] << requirement
assembly_line.rules[piece].sort!
end



until assembly_line.rules.empty?
next_pieces = assembly_line.find_next
if next_pieces.empty?
assembly_line.pass_time
else
next_pieces.each do |next_piece|
# assembly_line.order << next_piece
assembly_line.add_time(next_piece)
assembly_line.rules.delete(next_piece)
end
end
end

assembly_line.pass_time until assembly_line.workers.collect {|worker| worker[:time]}.count(0) == assembly_line.workers.length

puts assembly_line.time