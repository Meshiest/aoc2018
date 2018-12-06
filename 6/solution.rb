input = open('input.txt')
  .read
  .chomp
  .split("\n")
  .map{ |l| l.split(',').map(&:to_i) }

dim = input.flatten.max

counts = [0] * input.size
infinite = [false] * input.size
close = 0

grid = (0..dim).map{ |y| (0..dim).map{ |x|
  min_dist = dim * dim
  min_index = -1
  total = 0

  input.each_with_index{|(a, b), i|
    # Get Manhattan distance
    total += dist = (a-x).abs + (b-y).abs

    # Find the minimum unique distance
    if dist < min_dist
      min_dist, min_index = dist, i
    elsif dist == min_dist
      min_index = -2
    end
  }

  # Count cells within 10k distance (Part 2)
  close += 1 if total < 10000

  next min_index unless min_index >= 0

  if x == 0 || x == dim || y == 0 || y == dim
    infinite[min_index] = true
  else
    counts[min_index] += 1
  end

  min_index
}}

CHARS = [?0..?9, ?A..?Z].map(&:to_a).flatten + '!@#$%^&'.chars
display_grid = grid.map(&:clone)
display_grid = display_grid.map{|a|a.each_slice(2).map(&:first)}.each_slice(2).map(&:first) until display_grid.size <= 50

puts "Visual:"
puts display_grid.map{|arr| arr.map{|l|(l == -2 ? '.' : (l == -1 ? '' : CHARS[l].to_s))}*''}*"\n"

puts "Part 1: " + counts.zip(infinite).reject(&:last).map(&:first).max.to_s
puts "Part 2: " + close.to_s
