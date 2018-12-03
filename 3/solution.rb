input = open('input.txt')
  .read
  .split("\n")

# Hash of areas that overlap more than one area
not_alone = {}

# Hash of tiles that are covered by an area
grid = {}

input.each {|line|
  # Parse arguments
  args = line.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
  id = args[1].to_i
  x = args[2].to_i
  y = args[3].to_i
  width = args[4].to_i
  height = args[5].to_i

  # Iterate through the entire area
  (x...x + width).each do |x|
    (y...y + height).each do |y|
      # Store which ids are on which spot
      grid[[x, y]] ||= []
      grid[[x, y]] << id

      # Remove potential single tiles
      grid[[x, y]].each do |id|
        not_alone[id] = true
      end if grid[[x, y]].size > 1
    end
  end
}

# Count the number of tiles with more than one overlapping areas
puts "Part 1: " + grid.values.count{ |a| a.size > 1 }.to_s

# Get the areas that do not overlap with any other area
puts "Part 2: " + grid.values.select{ |a|a.size == 1 and not not_alone[a.first] }.flatten.uniq.join(',')
