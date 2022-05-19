class LinkedList
    def initialize
        @head = nil
    end

    def append(value)
        new_node = Node.new(value)
        if @head == nil
            @head = new_node
        else
            node = @head
            while node.next_node != nil
                node = node.next_node
            end
            node.next_node = new_node
        end
    end

    def prepend(value)
        new_node = Node.new(value, @head)
        @head = new_node
    end

    def size
        counter = 0
        node = @head
        until node.nil?
            counter += 1
            node = node.next_node
        end
        counter
    end
   
    def head
        @head.value
    end

    def tail
        node = @head
        until node.next_node == nil 
            node = node.next_node
        end
        node.value
    end

    def at(index)
        node = @head
        index.times {node = node.next_node}
        node.value
    end

    def pop
        node = @head
        until node.next_node.next_node == nil
            node = node.next_node
        end
        node.next_node = nil
    end

    def contains?(value)
        node = @head
        found_value = false
        until node.nil?
            if node.value == value
                found_value = true
                break
            else 
                node = node.next_node
            end
        end
        found_value
    end

    def find(value)
        node = @head
        counter = 0
        found = false
        until node.nil?
            if node.value == value
                found = true
                break
            else 
                counter += 1
                node = node.next_node
            end
        end
        found == false ? (puts "nil") : (puts counter)
    end

    def insert_at(value, index)
        node = @head
        if index == 0
            prepend(value)
        elsif index >= size()
            append(value)
        else
            (index-1).times {node = node.next_node}
            new_node = Node.new(value, node.next_node)
            node.next_node = new_node
            append(new_node) if new_node.next_node.nil?
        end
    end

    def remove_at(index)
        node = @head
        if index == 0
            @head = node.next_node
        elsif index >= size()
            puts "Index larger than list size, no item to remove"
        else
            (index-1).times {node = node.next_node} 
            after_node = node.next_node.next_node
            node.next_node = after_node
        end
    end

    def print_list
        node = @head
        print "#{node.value.to_s} -> "
        while (node = node.next_node)
            print "#{node.value.to_s} -> "
        end
        print "nil \n"
    end
end

class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
        @value = value
        @next_node = next_node
    end

end

list = LinkedList.new

list.append(15)
list.append(3)
list.append(4)
list.prepend(1)
list.append("last")
list.print_list
puts list.size
puts list.head
puts list.tail
puts list.at(2)
list.pop
list.print_list
puts list.contains?(15)
list.find(4)
list.insert_at(18, 7)
list.print_list
list.remove_at(2)
list.print_list