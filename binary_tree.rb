class Node
  attr_accessor :left_child, :right_child
  attr_reader :data, :parent
  def initialize (data, parent = nil, left_child = nil, right_child = nil )
    @data = data
    @parent = parent
    @left_child = left_child
    @right_child = right_child
  end
end

def build_tree(arr)
  root_node = Node.new(arr[0])
  arr.each_with_index { |e, i| add_node(e, root_node) if i != 0 }
  root_node
end

def add_node(node_data, parent)
  child = Node.new(node_data, parent)
   #first handle case for leaf nodes
   #if the node is smaller (or ==) the parent, it goes on the left.
  if node_data <= parent.data && parent.left_child.nil?
    parent.left_child = child
  elsif node_data > parent.data && parent.right_child.nil?
    parent.right_child = child
  else
    #recursively handle case if child is not a leaf node
    node_data < parent.data ? add_node(node_data, parent.left_child) : add_node(node_data, parent.right_child)
  end
end
#visit all nodes on the same level before visiting nodes on the next
#so check root, then all of roots children, then all of roots children's children etc
def breadth_first_search(node_to_search, target_value)
  queue = []
  queue.push(node_to_search)

  until queue.empty?
    return queue[0] if queue[0].data == target_value
    #if not, next we'll check left child, and then right_child
    queue << queue[0].left_child if queue[0].left_child != nil
    queue << queue[0].right_child if queue[0].right_child != nil
    #delete the checked node
    queue.shift
  end
  return nil
end

example = build_tree([0,1,2,3,84,233,144,21,55,8,5,34,13])
puts breadth_first_search(example, 84)

#complete the whole sub-tree before going to next child
def depth_first_search(node_to_search, target_value)
  stack = []
  stack.push(node_to_search)

  until stack.empty?
    location = stack[-1]
    stack.pop
    return location if location.data == target_value
    #add the right child to stack first, because the last item from stack is removed first
    #and we want to complete the left subt-tree first
    stack << location.right_child if location.right_child != nil
    stack << location.left_child if location.left_child != nil
  end
  return nil
end

puts depth_first_search(example,84)

def dfs_rec(node, target_value)
  return nil if node.nil?
  return node if node.data == target_value
  dfs_rec(node.left_child, target_value) if node.left_child
  dfs_rec(node.right_child, target_value) if node.right_child
end

puts dfs_rec(example,84)
