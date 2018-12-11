input = open('input.txt')
  .read
  .split("\n")
  .map{ |l| l.scan(/ (?:[A-Z]) /).map(&:strip) }

NUM_WORKERS = 5

# Init deps array
deps = input.flatten.uniq.each_with_object({}){ |l, o| o[l] = [] }

# Load up deps from each input
input.each{ |before, target| deps[target] <<= before }

# Duplicate the array for part 2
copy = deps.entries.each_with_object({}){|(k,v), o| o[k] = v.clone}

used = []
until used.size == deps.size
  # Get all the available chars
  avail = deps
    .entries
    .reject{ |l, dep| dep.size > 0 || used.include?(l) }
    .map(&:first)
    .min

  # Concat the next available
  used <<= avail

  # Remove it from the deps
  deps.each{|k, v| v.delete(avail)}
end

# Store the output
part1 = used*''

# Use the copy
deps = copy

# Init our workers
workers = Array::new(NUM_WORKERS) {[-1, '.']}
secs = 0
used = []
done = []

until done.size == deps.size

  # Remove the work that is finished
  workers.map!{|work, letter|
    if work == 0 and letter != '.'
      done <<= letter
      deps.each{|k, v| v.delete(letter)}
      work = -1
      letter = '.'
    end
    [work, letter]
  }

  # Increment time if we have work left
  secs += 1 unless done.size == deps.size

  # Get available chars
  avail = deps
    .entries
    .reject{ |l, dep| dep.size > 0 || used.include?(l) }
    .map(&:first)
    .sort
  
  workers.map!{ |work, letter|
    # Assign new work when available
    if work < 0 and avail.size > 0
      used <<= letter = avail.shift
      work = 61 + letter.ord - 'A'.ord
    end

    # Do some work
    work -= 1 if work > 0

    [work, letter]
  }

  # Print out a row of status!
  puts "#{secs.to_s.rjust(5)} | #{workers.map{|w|w.last.center(3)}*''} | #{done*''}"
end

puts "Part 1: #{part1}"
puts "Part 2: #{secs}"
