input = open('input.txt')
  .read
  .split("\n")
  .map{ |l| l.scan(/-?\d+/).map(&:to_i) }

min = 1.0 / 0

# Find the minimum dist between x values
time = 0.step { |i|
  break i - 1 if min < (min = input.map{ |x, _, vx, _| x + vx * i }.minmax.reduce(&:-).abs)
}

# Get the mins, maxes, and updated point positions
(xmin, xmax), (ymin, ymax) = (points =
  input
    .map{ |x, y, vx, vy| [x + vx * time, y + vy * time]}) # Move the points
  .transpose
  .map(&:minmax)

# Build 2d array for the points
chars = Array::new(ymax - ymin + 1){Array::new(xmax - xmin + 1){' '}}
points.each { |x, y| chars[y-ymin][x-xmin] = '#' }

puts 'Part 1: ', chars.map(&:join)*"\n"
puts "Part 2: #{time}"
