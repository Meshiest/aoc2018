input = open('input.txt')
  .read
  .split("\n")
  .sort
  .map{ |line| [
    line.scan(/\d+\]/).last.to_i, # Get the minute
    line.scan(/] .*/)[0][2..-1] # Get the action
  ]}

minutes = Array::new(60){[]} # Create a 60 length array of arrays

sleeping = false
start = 0
id = -1

input.each do |time, act|
  if act == 'falls asleep'
    # Start sleeping
    sleeping = true
    start = time
  else
    # Keep track of minutes slept
    (start...time).each { |i| minutes[i] << id } if sleeping
    
    # Store a new id if we have one
    ids = act.scan(/\d+/)
    id = ids[0].to_i if ids.length > 0

    # Stop sleeping
    sleeping = false
  end
end


# Find the guard (g) with the most minutes slept
guard = minutes.flatten.uniq.map{|g| [minutes.flatten.count(g), g]}.sort.last[1]

# Find the minute (m) the guard slept the most
minute = minutes.each_with_index.map{|guards, m| [guards.count(guard), m]}.sort.last[1]
puts "Part 1: #{guard} * #{minute} == #{guard * minute}"

# For each minute (m), track how many times the guard (d) slept, and find the largest
guard, minute = minutes.each_with_index.map{|guards, m| guards.uniq.map{|d| [guards.count(d), d, m]}}.reduce(&:+).sort.last[1..-1]
puts "Part 2: #{guard} * #{minute} == #{guard * minute}"

