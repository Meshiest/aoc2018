# Read in input as an array of integers
inputs = open("input.txt")
  .read
  .split("\n")
  .map(&:to_i)

freq = 0
seen = {0 => true}

# Print out the sum of all the frequencies
puts "Part 1: #{inputs.inject(&:+)}"

loop do
  # Loop through the "frequencies"
  break unless inputs.each do |i|
    # Stop if we've found one we've already seen
    break if seen[freq += i]

    # Now we've seen that frequency
    seen[freq] = true
  end
end

# Print out the frequency that was found
puts "Part 2: #{freq}"
