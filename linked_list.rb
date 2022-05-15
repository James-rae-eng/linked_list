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
        puts counter
    end
   
    def head
        puts @head.value
    end

    def tail
        node = @head
        until node.next_node == nil 
            node = node.next_node
        end
        puts node.value
    end

    def at(index)
        node = @head
        index.times {node = node.next_node}
        puts node.value
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
        puts found_value
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
        (index-1).times {node = node.next_node}
        new_node = Node.new(value, node.next_node)
        node.next_node = new_node
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
list.size
list.head
list.tail
list.at(2)
list.pop
list.print_list
list.contains?(15)
list.find(4)
list.insert_at(18, 2)
list.print_list