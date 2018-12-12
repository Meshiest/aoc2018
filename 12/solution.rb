input = open('input.txt')
  .read
  .split("\n")

curr_gen = Hash::new(0)

# Convert strings of dots and hashes into zeroes and ones
to_mask = -> x { x.chars.map{ |c| c == ?# ? 1 : 0 } }

# Select every index that matches this pattern
find_pattern = -> pat {
  curr_gen.select{ |i, _|
    pat.each_with_index.all?{ |bit, j|
      curr_gen[i - 2 + j] == bit
    }
  }
}

# Calculate the sums of indicies of ones
value_of = -> pots { pots.entries.map{ |k, v| v == 1 ? k : nil}.compact.reduce(&:+) }

# Convert the initial state into bits
to_mask[input[0].split.last].each_with_index{ |bit, i| curr_gen[i] = bit }

# Convert the patterns into bits
patterns = input[2..-1].map{ |l|
  pat, res = l.split(' => ')
  [to_mask[pat], to_mask[res][0]]
}.sort

curr_val = 0
delta = 0
stasis = 500.times { |j|
  next_gen = Hash::new(0)
  # Find the leftmost 1
  left = curr_gen.find{ |k, v| v == 1}.first

  # Cull unnecessary 0's
  curr_gen.each{ |k,v| next_gen[k] = v if k > left - 1}

  # Find the max index
  right = curr_gen.max[0]

  # Fill empty cells with 0's
  (left..right+2).each{ |i| curr_gen[i] = curr_gen[i] || 0}

  # Find each matching pattern and update bits
  patterns.each{ |pat, bit|
    find_pattern[pat].each{ |i, _|
      next_gen[i] = bit
    }
  }

  # Calculate the next sum of pot indices
  next_val = value_of[curr_gen = next_gen]

  puts "Part 1: #{next_val}" if j == 19

  # Determine difference between sums
  new_delta = next_val - curr_val

  # Stop if we found a cycle (deltas are the same)
  break j if delta == new_delta

  delta = new_delta
  curr_val = next_val
}

# Calculate what the value would be at time = 5 billion
puts "Part 2: #{curr_val + (50000000000 - stasis) * delta}"
