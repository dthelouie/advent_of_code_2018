# For example, again using the polymer dabAcCaCBAcCcaDA from above:

# Removing all A/a units produces dbcCCBcCcD. Fully reacting this polymer produces dbCBcD, which has length 6.
# Removing all B/b units produces daAcCaCAcCcaDA. Fully reacting this polymer produces daCAcaDA, which has length 8.
# Removing all C/c units produces dabAaBAaDA. Fully reacting this polymer produces daDA, which has length 4.
# Removing all D/d units produces abAcCaCBAcCcaA. Fully reacting this polymer produces abCBAc, which has length 6.
# In this example, removing all C/c units was best, producing the answer 4.

# What is the length of the shortest polymer you can produce by removing all units of exactly one type and fully reacting the result?

require 'pry'

letter_index = 0
alphabet = ('a'..'z').to_a
removed_counts = {}

def react?(letters)
  return false if letters[0].nil? || letters[1].nil?
  reaction = letters[0] != letters[1] && letters[0].upcase == letters[1].upcase
  return reaction
end

while letter_index < alphabet.length
  index = 0
  input = File.read('input5.txt').delete!("#{alphabet[letter_index].upcase}#{alphabet[letter_index]}")
  while index < input.length
    letters = [input[index], input[index + 1]]
    if react?(letters)
      input.slice!(index..index+1)
      index -= 1 unless index == 0
    else
      index += 1
    end
  end
  removed_counts["#{alphabet[letter_index].upcase}/#{alphabet[letter_index]}"] = input.length
  letter_index += 1
end
puts removed_counts.to_a.min { |a, b| a[1] <=> b[1] }.join(": ")