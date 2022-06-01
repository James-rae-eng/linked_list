
class Tree
    attr_accessor :array, :root 

    def initialize(input, root = nil)
        @array = input.sort.uniq
        @root = build_tree(array)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end

    def build_tree(array = @array, first = 0, last = (array.length - 1))
        return nil if first > last

        mid_index = (first + last)/2
        root = Node.new(array[mid_index])
        
        root.left_child = build_tree(array, first, (mid_index-1))
        root.right_child = build_tree(array, (mid_index+1), last)
        return root
    end

    def insert(root = @root, data)
        root = Node.new(data) if root == nil

        if data < root.data
            root.left_child = insert(root.left_child, data)
        elsif data > root.data
            root.right_child = insert(root.right_child, data)
        end

        return root
    end

    def delete(root = @root, data)
        return root if root == nil

        if data < root.data
            root.left_child = delete(root.left_child, data)
        elsif data > root.data
            root.right_child = delete(root.right_child, data)
        else
            if root.left_child == nil
                return root.right_child
            elsif root.right_child == nil
                return root.left_child
            end
            root.data = min_value(root.right_child)
            root.right_child = delete(root.right_child, root.data)
        end

        return root
    end

    def min_value(root)
        min_v = root.data
        while root.left_child != nil
            min_v = root.left_child.data
            root = root.left_child
        end
        return min_v
    end

    def find(root = @root, data)
        return root if root.data == data 

        if data < root.data
            find(root.left_child, data)
        elsif data > root.data
            find(root.right_child, data)
        end
    end

    def level_order(root = @root, block = nil)
        return root if root == nil
        queue = []
        output = []
        queue.push(root) if root != nil

        while queue.any?
            queue.push(queue[0].left_child) if queue[0].left_child != nil
            queue.push(queue[0].right_child) if queue[0].right_child != nil
            output.push(queue[0])
            queue.shift
        end
        value_array = output.map {|root| root.data}
    end

    def inorder(root = @root, block = nil)
        return root if root == nil
        inorder(root.left_child)
        print root.data
        inorder(root.right_child)
    end

    def preorder(root = @root, block = nil)
        return root if root == nil
        print root.data
        inorder(root.left_child)
        inorder(root.right_child)
    end

    def postorder(root = @root, block = nil)
        return root if root == nil
        inorder(root.left_child)
        inorder(root.right_child)
        print root.data
    end

    def height(node)
        return -1 if node == nil

        left_height = height(node.left_child)
        right_height = height(node.right_child)

        if left_height > right_height
            left_height + 1
        else
            right_height +1
        end 
    end

    def depth(root = @root, counter = 0, node)
        return counter if root.data == node.data 

        if node.data < root.data
            count = counter + 1
            depth(root.left_child, count, node)
        elsif node.data > root.data
            count = counter + 1
            depth(root.right_child, count, node)
        end
    end

    def balanced?(root = @root)
        return true if root == nil
        
        left_height = height(root.left_child)
        right_height = height(root.right_child)

        return true if (left_height - right_height).abs <= 1 && balanced?(root.left_child) && balanced?(root.right_child)
        false
    end

    def rebalance(root = @root)
        initialize(level_order(root).sort.uniq)
    end
end


class Node
    attr_accessor :data, :left_child, :right_child

    def initialize(data = nil, left_child = nil, right_child = nil)
        @data = data
        @left_child = left_child
        @right_child = right_child
    end
end

tree = Tree.new(Array.new(15){rand(1..100)})
puts tree.balanced?
print "#{tree.level_order}\n"
print "#{tree.inorder}\n"
print "#{tree.preorder}\n"
print "#{tree.postorder}\n"
tree.insert(111)
tree.insert(150)
tree.insert(200)
puts tree.balanced?
tree.rebalance
puts tree.balanced?
print "#{tree.level_order}\n"
print "#{tree.inorder}\n"
print "#{tree.preorder}\n"
print "#{tree.postorder}\n"
tree.pretty_print