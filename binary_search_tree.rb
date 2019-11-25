module BinarySearchTree
  def self.from_array(array)
    Node.new(array.first).tap do |tree|
      array.each {|v| tree.push v }
    end
  end
  class EmptyNode
    def to_a
      []
    end
    def bst_include?(*)
      false
    end
    def push(*)
      false
    end

    def inspect
      "{}"
    end
  end

  class Node
    attr_accessor :value
    attr_accessor :left, :right

    def initialize(v)
      @value = v
      @left = EmptyNode.new
      @right = EmptyNode.new
    end

    def push(v)
      p "#{v} already present in tree" and return false if bst_include?(v)
      case value <=> v
      when 1 then push_left(v)
      when -1 then push_right(v)
      when 0 then false
      end
    end

    def bst_include?(v)
      case value <=> v
      when 1 then left.bst_include?(v)
      when -1 then right.bst_include?(v)
      when 0 then return true
      else
        return false
      end
    end

    def inspect
      "{#{value} => #{left.inspect}|#{right.inspect}}"
    end

    def search(node, key)
      p "Oop's : value not found" and return false if node.class == RubyBst::EmptyNode
      if node.value == key
        p "Hey!! we found the value : #{node.value}" and return true
      elsif key < node.value
        search(node.left, key)
      else
        search(node.right, key)
      end
    end

    def to_a
      p value
      p left
      p right
      left.to_a + [value] + right.to_a
    end

    def children
      # children? ? ([left, right].compact and return true) : ("No children" and return false)
      [left, right].compact
    end

    # def children?
    #   !(left.class == RubyBst::EmptyNode)&& !(right.class = RubyBst::EmptyNode)
    # end

    def valid_bst(node, min=-1.0/0.0, max=1/0.0)
      return true if node.class == RubyBst::EmptyNode
      return false if node.children.count > 2
      return false if node.value < min || node.value > max
      return (valid_bst(node.left, min, node.value) &&
      valid_bst(node.right, node.value, max))
    end

    def find_lca_bst(node, x1, x2)
      if bst_include?(x1) && bst_include?(x2)
        return if node.class == RubyBst::EmptyNode
        return find_lca_bst(node.left, x1, x2) if (node.value > x1 && node.value > x2)
        return find_lca_bst(node.right, x1, x2) if (node.value < x1 && node.value < x2)
        p "LCA of #{x1} and #{x2} is #{node.value}" and return true
      else
        [x1,x2].each{|x| p "Element #{x} is not present in BST" if !bst_include?(x)}
        return false
      end
    end

    # DSF - In[Le,Ro,Ri], Pre[Ro,Le,Ri] & Post[le, Ri, Ro] order
    def print_inorder node
      # [Left, Root, Right]
      return if node.class == RubyBst::EmptyNode
      print_inorder node.left
      print "#{node.value}, "
      print_inorder node.right
    end
    def print_preorder node
      # [Root, Left, Right]
      return if node.class == RubyBst::EmptyNode
      print "#{node.value}, "
      print_preorder node.left
      print_preorder node.right
    end
    def print_postorder node
      # [Left, Right, Root]
      return if node.class == RubyBst::EmptyNode
      print_postorder node.left
      print_postorder node.right
      print "#{node.value}, "
    end

    def print_node node
       p "     #{node.value}     "
       p "------------- "
       p "|            |"
       p "#{node.left.value}           #{node.right.value}"
       return true
    end

    private
    def push_left(v)
      left.push(v) or self.left = Node.new(v)
    end

    def push_right(v)
      right.push(v) or self.right = Node.new(v)
    end
  end
end

require 'benchmark'
p "Enter a array size"
nn = gets.chomp.to_i
test_array = (1..nn).to_a.shuffle
p "Random generated array : #{test_array}"
p "--- BST generation ---"
tree = BinarySearchTree::Node.new(test_array.first)
test_array.each {|value| tree.push(value) }

Benchmark.bm do |benchmark|
  benchmark.report("test_array include"){ (1..nn).each {|n| test_array.include? n } }
  benchmark.report("binary tree search"){ (1..nn).each {|n| tree.bst_include? n } }
end
