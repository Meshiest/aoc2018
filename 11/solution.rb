SERIAL = 1718
grid = Array::new(300){[0] * 300}

# Build our grid of power levels
300.times do |y|
  300.times do |x|
    rack = x + 10
    power = rack * y
    power += SERIAL
    power *= rack
    grid[y][x] = power / 100 % 10 - 5
  end
end

def find grid, size
  (1..299).map{ |x|
    (1..299).map{ |y|
      # Get the sum of the area
      [grid[y-1, size].sum{ |row| row[x-1, size].sum }, [x-1, y-1]]
    }
  }.reduce(&:+).sort.last # Find the largest
end

_, (x, y) = find grid, 3
puts "Part 1: #{x},#{y}"
# Print out the area
puts grid[y-1, 5].map{ |row| row[x-1, 5].map{ |c| c.to_s.center(3) }*'' }*"\n"

# Assuming the area averages to around 10 past 20, this should be good enough
_, (x, y), size = (1..20).map{ |i| (find grid, i) + [i] }.sort.last
puts "Part 2: #{x},#{y},#{size}"
# Print out the area
puts grid[y-1, size+2].map{ |row| row[x-1, size+2].map{ |c| c.to_s.center(3) }*'' }*"\n"
