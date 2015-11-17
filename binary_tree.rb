class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value)
		@value=value
	end
end


class Tree
 attr_accessor :root_node

 def build_tree(ary)

  @root_node = nil
  ary.each do |number|

    #print "processing #{number}\n"
    if @root_node == nil
	#puts "create root node with no children"
	@root_node = Node.new(number)
	#puts "created root node #{@root_node}\n"
    else
      not_inserted = true
      current_node = @root_node # start at root node

      while not_inserted do
	if number > current_node.value
		if current_node.right_child == nil
			#puts "bottom of right branch reached, add node here"
			current_node.right_child = Node.new(number)
			current_node.right_child.parent = current_node
			#print "added new right node with value #{current_node.right_child.value} under #{current_node.value}\n"
			not_inserted = false
		else
			current_node = current_node.right_child
		end
	else # number < current_node.value
		if current_node.left_child == nil
			#puts "bottom of left branch reached, add node here"
			current_node.left_child = Node.new(number)
			current_node.left_child.parent = current_node
			#print "added new left node with value #{current_node.left_child.value} under #{current_node.value}\n"
			not_inserted = false
		else
			current_node = current_node.left_child
		end
	end # if number

       end #while

      end # if defined
      
  end #ary.each
  print "creation of #{ary} tree completed\n"
 end # build


 def simple_search(target)
	not_found = true
	current_node = @root_node
	while not_found
		if target == current_node.value
			print "target #{target} found\n"
			not_found = false
		elsif target > current_node.value && current_node.right_child != nil
			print "target #{target} > current_node.value #{current_node.value}, right branch\n"
			current_node = current_node.right_child
		elsif current_node.left_child != nil
			print "target #{target} < current_node.value #{current_node.value} left branch\n"
			current_node = current_node.left_child 
		else
			print "#{target} not found\n"
			not_found = false
		end
	end
 end #simple search

 def simple_search_recursive(target, current_node=@root_node)
	if target == current_node.value
		print "target #{target} found\n"
	elsif target > current_node.value && current_node.right_child != nil
		print "target #{target} > current_node.value #{current_node.value}, right branch\n"
		current_node = current_node.right_child
		simple_search_recursive(target, current_node)
	elsif current_node.left_child != nil
		print "target #{target} < current_node.value #{current_node.value} left branch\n"
		current_node = current_node.left_child
		simple_search_recursive(target, current_node)
	else
		print "#{target} not found\n"
	end

 end # simple search recursive


 def diagnostic_output(array_to_print)
	result=[]
	array_to_print.each {|member| result << member.value}
	result
 end

 def breadth_first_search(target_value)
=begin 
	takes a target value and returns the node at which it is located using the breadth first search technique. 
	Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet 
	to search and to add new ones to the list (as you saw in the video). If the target node value is not located, return nil
=end
  node_queue=[]
  visited = [] # use to "mark visited"

  notfound = true

  node_queue << @root_node



  while notfound && node_queue.length > 0

    current_node = node_queue.shift

    if current_node.value == target_value
      print "found #{target_value}\n"
      notfound = false
    else
      # "visit node and mark it as visited"
      if ! visited.include?(current_node)
        visited << current_node
        print "visited list is now #{diagnostic_output(visited)}\n"
      end # if ! visited
      # determine which child node has a smaller value
      children_nodes = []
      children_nodes << current_node.left_child if current_node.left_child != nil
      children_nodes << current_node.right_child if current_node.right_child != nil
      if children_nodes.length == 2 && children_nodes[0].value > children_nodes[1].value
	children_nodes.reverse!
      end #if children_nodes
      # add unvisited child nodes to the queue (use push to add and shift to remove)
      children_nodes.each do |child|
	if ! visited.include?(child)
	  node_queue << child
	  visited << child
          print "node_queue is now #{diagnostic_output(node_queue)}\n"
	  print "visited list is now #{diagnostic_output(visited)}\n"
	end # if visited
      end # children_nodes.each


    end # if current_node.value

  end # while notfound
  print "#{target_value} not found\n" if notfound

 end # breadth_first_search



 def depth_first_search(target_value)
=begin 
	returns the node at which the target value is located using the depth first search technique. 
	Use an array acting as a stack to do this.
=end
  node_stack=[]
  visited = [] # use to "mark visited"

  notfound = true

  node_stack << @root_node

  while notfound && node_stack.length > 0

    current_node = node_stack.last
    print "current_node is now #{current_node.value}\n"

    if current_node.value == target_value
      print "found #{target_value}\n"
      notfound = false
    else
      # "visit node and mark it as visited"
      if ! visited.include?(current_node)
        visited << current_node
        print "visited list is now #{diagnostic_output(visited)}\n"
      end # if ! visited
      # if there are any unvisited children, visit (only) the one with lower value
      # determine if there is an unvisited child, and if there are two, determine which has a smaller value
      children_nodes = []
      children_nodes << current_node.left_child if current_node.left_child != nil && ! visited.include?(current_node.left_child)
      children_nodes << current_node.right_child if current_node.right_child != nil && ! visited.include?(current_node.right_child)
      if children_nodes.length == 2 && children_nodes[0].value > children_nodes[1].value
	children_nodes.reverse!
      end #if children_nodes
      print "children_nodes is now #{diagnostic_output(children_nodes)}\n"

      if children_nodes[0] != nil
	node_stack << children_nodes[0]
	visited << children_nodes[0]
        print "node_stack is now #{diagnostic_output(node_stack)}\n"
	print "visited list is now #{diagnostic_output(visited)}\n"

      else
	temp = node_stack.pop #pop this node off the stack because all it's children have been visited or are null
	print "popped #{temp.value} off the stack\n"
      end # if ! children_nodes[0]

    end # if current_node.value

  end # while notfound
  print "#{target_value} not found\n" if notfound

 end # depth_first_search




 def dfs_rec(target_value, node_to_check = @root_node, visited = [])
=begin 
	build a new method dfs_rec which runs a depth first search as before but this time, 
	instead of using a stack, make this method recursive. Tips: You can think of the dfs_rec 
	method as a little robot that crawls down the tree, checking if a node is the correct 
	node and spawning other little robots to keep searching the tree. No robot is allowed 
	to turn on, though, until all the robots to its left have finished their task. The 
	method will need to take in both the target value and the current node to compare against.
=end

    notfound = true
    current_node = node_to_check
    print "current_node is now #{current_node.value}\n"

    if current_node.value == target_value
      print "found #{target_value}\n"
      notfound = false
      return notfound
    else
      # "visit node and mark it as visited"
      if ! visited.include?(current_node)
        visited << current_node
        print "visited list is now #{diagnostic_output(visited)}\n"
      end # if ! visited
      # if there are any unvisited children, visit (only) the one with lower value
      # determine if there is an unvisited child, and if there are two, determine which has a smaller value
      children_nodes = []
      children_nodes << current_node.left_child if current_node.left_child != nil && ! visited.include?(current_node.left_child)
      children_nodes << current_node.right_child if current_node.right_child != nil && ! visited.include?(current_node.right_child)
      if children_nodes.length == 2 && children_nodes[0].value > children_nodes[1].value
	children_nodes.reverse!
      end #if children_nodes
      print "children_nodes is now #{diagnostic_output(children_nodes)}\n"

      if children_nodes[0] != nil
	visited << children_nodes[0]
	print "visited list is now #{diagnostic_output(visited)}\n"
	notfound = dfs_rec(target_value, children_nodes[0], visited)
      elsif current_node.parent != nil
	print "next node to visit will be parent #{current_node.parent.value}\n"
	notfound = dfs_rec(target_value, current_node.parent, visited)
      end # if ! children_nodes[0]

    end # if current_node.value


  print "#{target_value} not found\n" if notfound

 end # dfs_rec




end # Tree

tree = Tree.new
tree.build_tree [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].shuffle
target = 324
print "--simple search:\n"
tree.simple_search(target)
print "--simple search recursive:\n"
tree.simple_search_recursive(target)
print "--breadth first search:\n"
tree.breadth_first_search(target)
print "--depth first search:\n"
tree.depth_first_search(target)
print "--dfs_rec:\n"
tree.dfs_rec(target)
