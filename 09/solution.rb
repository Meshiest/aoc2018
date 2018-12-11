input = open('input.txt')
  .read
  .split("\n").
  map{ |l| l.scan(/\d+/).map(&:to_i) }

# Ring buffer because using an array is wayyy to laggy ;(
class Ring
  def initialize
    @left = [0]
    @right = []
  end

  # Remove from the middle
  def pop
    @left, @right = @right, [] if @left.empty?
    @left.pop
  end

  # Insert to the middle
  def push n
    @left.push n
  end

  # Rotate clockwise
  def rotate_cw
    @right, @left = @left, [] if @right.empty?
    @left.push @right.shift
  end

  # Rotate counter clockwise
  def rotate_ccw
    @left, @right = @right, [] if @left.empty?
    @right.unshift @left.pop
  end
end


def play players, last
  marbles = Ring::new
  remaining = (1..last).to_a
  player = 0
  scores = [0] * players

  while marble = remaining.shift
    player += 1

    if marble % 23 == 0 # Handle marbles divisible by 23
      7.times{ marbles.rotate_ccw }
      # Update score with current marble and marble 7 counter clockwise
      scores[player % players] += marble + marbles.pop
      marbles.rotate_cw
    else
      # Insert the next marble
      marbles.rotate_cw
      marbles.push marble
    end
  end

  # Get the max score
  scores.max
end

players, last = input[0]
puts "Part 1: #{play players, last}"
puts "Part 2: #{play players, last * 100}"
