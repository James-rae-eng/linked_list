class Knight
    attr_accessor :position, :children, :parent
  
    def initialize(position, parent = nil)
      @position = position
      @parent = parent
      @children = []
    end

    def next_moves(value = @position)
        potential_moves = [[value[0] + 2, value[1] + 1],
            [value[0] + 2, value[1] - 1],
            [value[0] + 1, value[1] + 2],
            [value[0] + 1, value[1] - 2],
            [value[0] - 2, value[1] + 1],
            [value[0] - 2, value[1] - 1], 
            [value[0] - 1, value[1] + 2], 
            [value[0] - 1, value[1] - 2]]
        
        valid_moves = potential_moves.select do |move|
            move[0].between?(0,7) &&
            move[1].between?(0,7)
        end
    end
end


def knight_moves(start, destination)
    current = make_tree(start, destination)
    history = []
    make_history(current, history, start)
    print_knight_moves(history, start, destination)
end

def make_tree(start, destination)
    queue = [Knight.new(start)]
    current = queue.shift
    until current.position == destination
        current.next_moves.each do |move|
        current.children << knight = Knight.new(move, current)
        queue << knight
        end
        current = queue.shift
    end
    current
end

def make_history(current, history, start)
    until current.position == start
        history << current.position
        current = current.parent
    end
    history << current.position
end

def print_knight_moves(history, start, destination)
    puts "You made it in #{history.length - 1} moves! Here's the path:"
    history.reverse.each {|move| puts move.to_s}
end


knight_moves([0,5], [3,7])