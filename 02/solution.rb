input = open("input.txt")
  .read
  .split("\n")
  .map(&:chars)

puts "Part 1: " + input
  .map{ |str|
    # Get the counts of each character
    str.uniq.map{ |c| str.count(c) }
  }
  .reduce([0, 0]) { |(twos, threes), counts| [
    twos + (counts.include?(2) ? 1 : 0), # Add one for every count with two
    threes + (counts.include?(3) ? 1 : 0), # Add one for every count with three
  ]}
  .inject(&:*) # Multiply them together
  .to_s

puts "Part 2: " + input
  .map{ |str_a| # Iterate through every string
    # Iterate through the other strings
    (input - str_a).map{ |str_b|
      [str_a, str_b]
        .transpose # Create an array for comparing characters
        .each_with_object({str: '', count: 0}){ |(a, b), obj|
          if a == b
            # If the characters are the same, append to the string
            obj[:str] += a
          else
            # Otherwise, increase the number of different characters
            obj[:count] += 1
          end
        }
    }
  }
  .flatten
  .find{ |obj| obj[:count] == 1 }[:str]
