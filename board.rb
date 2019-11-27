require 'byebug'
require_relative 'tile.rb'

class Board
  attr_reader :board

  def initialize(x, y)
    unless x.is_a?(Integer) && y.is_a?(Integer) && (x * y).even?
      raise "both arguments must be integers, and their product must be even" 
    end

    coords = []
    #we create an x by y sized grid
    @board = Array.new(x) { |idx| Array.new(y) { |idx2| coords << [idx, idx2]; nil}}
    #and fill it with random doubles
    until coords.empty?
      rand_char = ('A'..'Z').to_a.shuffle[0]
      2.times {
        pos = coords[rand(coords.length)]
        @board[pos[0]][pos[1]] = Tile.new(rand_char)
        coords.delete_if { |i| i.equal?(pos) }
      }
    end
  end

  def print_board
    first_line = ""
    @board[0].length.times { |i| first_line += "#{i} " }
    p "  " + first_line
    @board.each_with_index { |row, idx| 
      line = idx.to_s + " "
      row.each { |pos|
        line += pos.name + " "
      }
      p line
    }
  end

  def reveal_pos(x,y)
    unless x.is_a?(Integer) && y.is_a?(Integer)
      raise "both arguments must be integers" 
    end

    @board[x][y].reveal
  end

  def hide_pos(x,y)
    unless x.is_a?(Integer) && y.is_a?(Integer)
      raise "both arguments must be integers" 
    end

    @board[x][y].hide
  end
end