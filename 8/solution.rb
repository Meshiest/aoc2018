input = open('input.txt')
  .read
  .split(' ')
  .map(&:to_i)

# Build the tree using the input as a queue
def get_node input
  nodes, metas = input.shift 2
  {
    nodes: nodes.times.map{get_node input}, # Read child nodes before getting meta
    meta: input.shift(metas), # Meta comes after child nodes
  }
end

# Sum up the metas of the node and its children
def meta_sum node
  node[:nodes].sum{ |n| meta_sum n } + node[:meta].sum
end

# Get the node value
def node_value node
  node[:nodes].empty? ?
    node[:meta].sum : # Value is sum of meta if there are no children
    node[:meta].sum{ |i|
      node[:nodes][i - 1] ? # Value is value of Ith child or 0
        (node_value node[:nodes][i - 1]) :
        0
    }
end

# Get build the tree
root = get_node input

puts "Part 1: #{meta_sum root}"
puts "Part 2: #{node_value root}"
