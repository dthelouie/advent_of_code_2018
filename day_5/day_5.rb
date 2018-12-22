# In aA, a and A react, leaving nothing behind.
# In abBA, bB destroys itself, leaving aA. As above, this then destroys itself, leaving nothing.
# In abAB, no two adjacent units are of the same type, and so nothing happens.
# In aabAAB, even though aa and AA are of the same type, their polarities match, and so nothing happens.
# dabAcCaCBAcCcaDA  The first 'cC' is removed.
# dabAaCBAcCcaDA    This creates 'Aa', which is removed.
# dabCBAcCcaDA      Either 'cC' or 'Cc' are removed (the result is the same).
# dabCBAcaDA        No further actions can be taken.

require 'pry'

input = File.read('input5.txt').delete('eE')
index = 0

def react?(letters)
  return false if letters[0].nil? || letters[1].nil?
  reaction = letters[0] != letters[1] && letters[0].upcase == letters[1].upcase
  return reaction
end

while index < input.length
  letters = [input[index], input[index + 1]]
  if react?(letters)
    input.slice!(index..index+1)
    index -= 1 unless index == 0
  else
    index += 1
  end
end

puts input.length